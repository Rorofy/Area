const axios = require("axios"); //request manager
const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  service: "gmail.com",
  port: "465",
  secure: true,
  auth: {
    user: "fz.epitech@gmail.com",
    pass: "Epitech123",
  },
});

function mailTo(receiver, text) {
  const mailOptions = {
    from: "fz.epitech@gmail.com",
    to: receiver,
    subject: "YEP AREA",
    text
  };
  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log("Email sent: " + info.response);
    }
  });
}

module.exports.mailTo = mailTo