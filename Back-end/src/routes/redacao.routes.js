const express = require('express');
const router = express.Router();
const redacaoController = require('../controller/redacao.controller');


router.post('/corrigir', redacaoController.corrigir);

module.exports = router;