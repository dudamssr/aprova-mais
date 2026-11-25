const express = require('express');
const router = express.Router();
const perfilController = require('../controller/perfil.controller');


router.get('/:id', perfilController.buscarPerfil);

module.exports = router;