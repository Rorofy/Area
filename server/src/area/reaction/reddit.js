const axios = require('axios');
var querystring = require('querystring');
redditMessageUrl = "https://oauth.reddit.com/api/compose";

async function alertUser(token, msg) {
    let tmp = token;
    if (token.includes("\"")) {
        tmp = token.substring(1, token.length - 1)
    }
    try {
        const user = await axios.get("https://oauth.reddit.com/api/v1/me", {
            headers: {
              Authorization: `Bearer ${tmp}`,
              "Content-Type": "application/x-www-form-urlencoded",
            }})
        const data = {
            subject: "Area notification",
            to: user.data.name,
            text: msg
        };
        const alert = await axios.post(redditMessageUrl, querystring.stringify(data), {
        headers: {
          Authorization: `Bearer ${tmp}`,
          "Content-Type": "application/x-www-form-urlencoded",
        }
        })
        console.log("Message sent: " + alert);
    } catch (e) {
        console.error(e)
    }
}

module.exports.alertUser = alertUser;