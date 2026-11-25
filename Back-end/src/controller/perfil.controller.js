const prisma = require('../data/prisma'); // Importa o Prisma Client corretamente

const buscarPerfil = async (req, res) => {
    try {
        const { id } = req.params;

        // Converte o ID para número (caso no banco seja Int)
        const usuarioId = Number(id);

        // Busca o usuário no banco usando o Prisma
        const usuario = await prisma.usuario.findUnique({
            where: { id: usuarioId },
            select: { id: true, nome: true, email: true } // Seleciona apenas o que precisa
        });

        if (!usuario) {
            return res.status(404).json({ erro: 'Usuário não encontrado.' });
        }

        // Retorna os dados para o frontend
        return res.status(200).json(usuario);

    } catch (erro) {
        console.error('ERRO AO BUSCAR PERFIL:', erro);
        return res.status(500).json({ erro: 'Erro interno no servidor.' });
    }
};

module.exports = { 
    buscarPerfil
 };