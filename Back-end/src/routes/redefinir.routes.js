
const express = require('express');
const router = express.Router();

const {
    verificarEmail,
    redefinirSenha
} = require('../controller/redefinir.controller');

router.post('/esqueci-senha', verificarEmail);
router.post('/redefinir-senha', redefinirSenha);

module.exports = router;
