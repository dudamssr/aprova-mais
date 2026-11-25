
const jwt = require('jsonwebtoken');

const verificarAdmin = (req, res, next) => {
    const authHeader = req.headers.authorization;

    if (!authHeader) {
        return res.status(401).json({
            mensagem: 'Acesso não autorizado.'
        });
    }

    const partes = authHeader.split(' ');
    const esquema = partes[0];
    const token = partes[1];

    if (esquema !== 'Bearer' || !token) {
        return res.status(401).json({
            mensagem: 'Token inválido.'
        });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        if (decoded.tipo !== 'admin') {
            return res.status(403).json({
                mensagem: 'Acesso permitido somente ao administrador.'
            });
        }

        req.admin = decoded;
        next();

    } catch (error) {
        return res.status(401).json({
            mensagem: 'Token expirado ou inválido.'
        });
    }
};

module.exports = verificarAdmin;
