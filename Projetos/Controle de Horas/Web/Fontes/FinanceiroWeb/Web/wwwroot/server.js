require('dotenv').config();
const express = require('express');
const nodemailer = require('nodemailer');
const multer = require('multer');
const cors = require('cors');
const app = express();

// Habilita CORS e JSON
app.use(cors());
app.use(express.json());

// Log das variáveis de ambiente
console.log('Iniciando servidor...');
console.log('Email configurado:', process.env.EMAIL_USER);

// Configurações do email
const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 587,
    secure: false,
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
    }
});

// Rota de teste
app.get('/api/test', (req, res) => {
    res.json({ message: 'Servidor funcionando!' });
});

app.post('/api/enviar-email', multer().single('attachment'), async (req, res) => {
    console.log('Recebendo requisição de email');
    console.log('Body:', req.body);
    console.log('File:', req.file ? 'Arquivo recebido' : 'Nenhum arquivo');

    try {
        if (!req.file) {
            throw new Error('Nenhum arquivo PDF recebido');
        }

        const info = await transporter.sendMail({
            from: process.env.EMAIL_USER,
            to: req.body.to,
            subject: 'Dados de Serviços Prestados',
            text: 'Segue em anexo o demonstrativo de serviços prestados.',
            attachments: [{
                filename: 'servicos-prestados.pdf',
                content: req.file.buffer
            }]
        });

        console.log('Email enviado com sucesso:', info.messageId);
        res.json({ success: true, messageId: info.messageId });
    } catch (error) {
        console.error('Erro ao enviar email:', error);
        res.status(500).json({ 
            error: 'Erro ao enviar email', 
            details: error.message 
        });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
}); 