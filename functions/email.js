const functions = require('firebase-functions');
const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'joaoantoniolaraujo@gmail.com',
        pass: 'wbun norg mbzd zvbl'
    }
});

exports.sendEmails = functions.https.onRequest(async (req, res) => {
    const { emailList, subject, text } = req.body;

    for (let email of emailList) {
        let mailOptions = {
            from: 'seuemail@gmail.com',
            to: email,
            subject: subject,
            text: text
        };

        try {
            let info = await transporter.sendMail(mailOptions);
            console.log('Email enviado: ' + info.response);
        } catch (error) {
            console.error('Erro ao enviar email para ' + email + ': ' + error.message);
            res.status(500).send('Erro ao enviar email');
            return;
        }
    }
    res.status(200).send('Emails enviados com sucesso');
});