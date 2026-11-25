
const jwt = require('jsonwebtoken');
const crypto = require('crypto');

const loginAdmin = (req, res) => {
    const { senha } = req.body;

    const senhaAdmin = process.env.ADMIN_PASSWORD;
    const jwtSecret = process.env.JWT_SECRET;

    if (!senhaAdmin || !jwtSecret) {
        return res.status(500).json({
            mensagem: 'Configuração do administrador não encontrada.'
        });
    }

    if (!senha) {
        return res.status(400).json({
            mensagem: 'Digite a senha.'
        });
    }

    const senhaDigitada = Buffer.from(String(senha));
    const senhaConfigurada = Buffer.from(senhaAdmin);

    const senhasIguais =
        senhaDigitada.length === senhaConfigurada.length &&
        crypto.timingSafeEqual(senhaDigitada, senhaConfigurada);

    if (!senhasIguais) {
        return res.status(401).json({
            mensagem: 'Senha incorreta.'
        });
    }

    const token = jwt.sign(
        { tipo: 'admin' },
        jwtSecret,
        { expiresIn: '2h' }
    );

    return res.status(200).json({
        mensagem: 'Login de administrador realizado!',
        token
    });
};

module.exports = {
    loginAdmin
};

