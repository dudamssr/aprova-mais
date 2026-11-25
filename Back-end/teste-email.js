
require('dotenv').config();

const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
    }
});

async function testar() {
    try {
        await transporter.verify();
        console.log('Conexão com Gmail funcionando!');
    } catch (erro) {
        console.error('Erro na conexão:', erro);
    }
}

testar();
