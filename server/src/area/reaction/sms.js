const accountSid = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const authToken = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
const client = require("twilio")(accountSid, authToken);

async function sendSMS(message, number) {
  client.messages
    .create({
      body: message,
      messagingServiceSid: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      to: number,
    })
    .then((message) => console.log(message.sid))
    .done();
}

module.exports.sendSMS = sendSMS;
