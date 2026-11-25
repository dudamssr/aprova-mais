const express = require('express');
const router = express.Router();
const iaController = require('../controller/ia.controller');


router.post('/duvida', iaController.tirarDuvida);

module.exports = router;