
const bcrypt = require('bcrypt');
const crypto = require('crypto');
const prisma = require('../data/prisma');
const { enviarEmail } = require('../services/email.services');

// 1. Verificar e-mail e enviar link de recuperação
const verificarEmail = async (req, res) => {
    try {
        const { email } = req.body;

        if (!email) {
            return res.status(400).json({
                erro: 'Por favor, informe o e-mail.'
            });
        }

        const usuario = await prisma.usuario.findUnique({
            where: { email }
        });

        console.log('E-mail informado:', email);
        console.log('Usuário encontrado:', !!usuario);

        // Resposta genérica para não revelar contas cadastradas
        if (!usuario) {
            return res.status(200).json({
                mensagem: 'Se o e-mail estiver cadastrado, você receberá as instruções.'
            });
        }

        // Invalidar tokens anteriores
        await prisma.tokenRecuperacao.updateMany({
            where: {
                usuarioId: usuario.id,
                utilizado: false
            },
            data: {
                utilizado: true
            }
        });

        // Gerar token seguro
        const token = crypto.randomBytes(32).toString('hex');

        // Armazenar somente o hash do token
        const tokenHash = crypto
            .createHash('sha256')
            .update(token)
            .digest('hex');

        const expiracao = new Date(Date.now() + 15 * 60 * 1000);

        // Salvar token no banco
        const registro = await prisma.tokenRecuperacao.create({
            data: {
                token: tokenHash,
                expiracao,
                usuarioId: usuario.id
            }
        });

        const link = `${process.env.FRONTEND_URL}/redefinir.html?token=${token}`;

        const mensagem = `
            <div style="font-family: Arial, sans-serif; max-width: 550px; margin: auto; color: #294663; padding: 20px;">
                <h2 style="color: #102f55;">Recuperação de senha - Aprov+</h2>

                <p>Olá, ${usuario.nome}!</p>

                <p>Recebemos uma solicitação para redefinir sua senha no Aprov+.</p>

                <p>Para criar uma nova senha, clique no botão abaixo:</p>

                <a href="${link}"
                
                   style="background: #299fd6; color: white; padding: 12px 20px; text-decoration: none; border-radius: 6px; display: inline-block;">
                    Redefinir minha senha
                </a>

                <p style="margin-top: 20px;">Este link é válido por 15 minutos e só pode ser utilizado uma vez.</p>

                <p>Se você não solicitou essa alteração, ignore este e-mail. Sua senha atual continuará a mesma.</p>

                <hr style="border: 0; border-top: 1px solid #e7edf3; margin: 25px 0;">

                <p style="font-size: 12px; color: #718096;">Equipe Aprov+</p>
            </div>
        `;

        try {
            // Enviar e-mail
            console.log('Iniciando envio do e-mail...');

            const resultadoEmail = await enviarEmail(
                usuario.email,
                'Recuperação de senha - Aprov+',
                mensagem
            );

            console.log('Resultado do envio:', resultadoEmail.response);
            console.log('Destinatário aceito:', resultadoEmail.accepted);
            console.log('Destinatário recusado:', resultadoEmail.rejected);

        } catch (erroEmail) {
            // Invalidar token caso o envio falhe
            await prisma.tokenRecuperacao.update({
                where: { id: registro.id },
                data: { utilizado: true }
            });

            throw erroEmail;
        }

        return res.status(200).json({
            mensagem: 'Se o e-mail estiver cadastrado, você receberá as instruções.'
        });

    } catch (erro) {
        console.error('ERRO AO VERIFICAR EMAIL:', erro);

        return res.status(500).json({
            erro: 'Erro ao solicitar recuperação de senha.'
        });
    }
};


// 2. Redefinir senha utilizando o token
const redefinirSenha = async (req, res) => {
    try {
        const { token, novaSenha } = req.body;

        if (!token || !novaSenha) {
            return res.status(400).json({
                erro: 'Dados incompletos.'
            });
        }

        if (typeof novaSenha !== 'string' || novaSenha.length < 8) {
            return res.status(400).json({
                erro: 'A senha deve ter pelo menos 8 caracteres.'
            });
        }

        // Gerar hash do token recebido
        const tokenHash = crypto
            .createHash('sha256')
            .update(token)
            .digest('hex');

        // Procurar token no banco
        const registro = await prisma.tokenRecuperacao.findUnique({
            where: { token: tokenHash }
        });

        if (!registro || registro.utilizado || registro.expiracao < new Date()) {
            return res.status(400).json({
                erro: 'Link inválido ou expirado.'
            });
        }

        // Criptografar nova senha
        const hashedPassword = await bcrypt.hash(novaSenha, 10);

        // Atualizar senha e invalidar token na mesma transação
        await prisma.$transaction([
            prisma.usuario.update({
                where: {
                    id: registro.usuarioId
                },
                data: {
                    senha: hashedPassword
                }
            }),

            prisma.tokenRecuperacao.update({
                where: {
                    id: registro.id
                },
                data: {
                    utilizado: true
                }
            })
        ]);

        return res.status(200).json({
            mensagem: 'Senha redefinida com sucesso!'
        });

    } catch (erro) {
        console.error('ERRO AO REDEFINIR SENHA:', erro);

        return res.status(500).json({
            erro: 'Erro ao atualizar a senha.'
        });
    }
};

module.exports = {
    verificarEmail,
    redefinirSenha
};


