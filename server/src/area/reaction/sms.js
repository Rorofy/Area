const accountSid = 'AC65accc517b42c556354365bb8b0e5368'; 
const authToken = '61365ea21fc10c0ebc654b2508ded2e0'; 
const client = require('twilio')(accountSid, authToken); 
 
async function sendSMS(message, number) {
  client.messages 
        .create({ 
           body: message,  
           messagingServiceSid: 'MGe365e42111b1b90ddebc15d646f5a677',      
           to: number 
         }) 
        .then(message => console.log(message.sid)) 
        .done();
}

module.exports.sendSMS = sendSMS