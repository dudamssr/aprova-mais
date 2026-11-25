
const jwt = require("jsonwebtoken");

const SECRET_KEY = process.env.JWT_SECRET;

const autenticarToken = (req, res, next) => {
    if (!SECRET_KEY) {
        return res.status(500).json({
            erro: "JWT_SECRET não configurada no servidor."
        });
    }

    const authHeader = req.headers.authorization;
    const token = authHeader && authHeader.split(" ")[1];

    if (!token) {
        return res.status(401).json({
            erro: "Acesso negado. Token não fornecido."
        });
    }

    try {
        const usuarioPayload = jwt.verify(token, SECRET_KEY);

        if (!usuarioPayload.id || !usuarioPayload.tipo) {
            return res.status(401).json({
                erro: "Token sem informações válidas."
            });
        }

        req.usuario = usuarioPayload;
        next();

    } catch (erro) {
        return res.status(403).json({
            erro: "Token inválido ou expirado."
        });
    }
};

const autorizarNivel = (...tipoPermitidos) => {
    return (req, res, next) => {
        if (
            !req.usuario ||
            !tipoPermitidos.includes(req.usuario.tipo)
        ) {
            return res.status(403).json({
                erro: "Acesso negado. Nível de acesso insuficiente."
            });
        }

        next();
    };
};

const autorizarAdmin = (req, res, next) => {
    if (
        !req.usuario ||
        req.usuario.id !== "admin" ||
        req.usuario.tipo !== "ADMIN" ||
        req.usuario.administrador !== true
    ) {
        return res.status(403).json({
            erro: "Acesso exclusivo do administrador."
        });
    }

    next();
};

module.exports = {
    autenticarToken,
    autorizarNivel,
    autorizarAdmin
};
