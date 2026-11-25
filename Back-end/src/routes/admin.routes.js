
const express = require('express');
const router = express.Router();

const { loginAdmin } = require('../controller/admin.controller');
const verificarAdmin = require('../middlewares/admin.middleware');

router.post('/login', loginAdmin);

router.get('/verificar', verificarAdmin, (req, res) => {
    res.status(200).json({
        autenticado: true,
        tipo: 'admin'
    });
});

module.exports = router;
