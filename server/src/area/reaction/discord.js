const Discord = require('discord.js');

function discordSend (url, str) {
    if (typeof url !== 'string' || url.length < 30) {
        return
    }
    const data = url.split('/');
    const res = {
        id: data[5],
        token: data[6]
    }
    const webhook = new Discord.WebhookClient(res);
    webhook.send(str);
}

module.exports.discordSend = discordSend