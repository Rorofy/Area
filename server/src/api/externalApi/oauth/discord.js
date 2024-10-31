const { Router } = require('express');
const router = new Router();
const axios = require('axios');
const { discord_clientID, discord_secret } = require('../../../const.json');
var querystring = require('querystring');
const REDIRECT_URI_DISCORD = 'http://localhost:8000/oauth/discord';

function get_code() {
  const rootUrl = "https://discord.com/api/oauth2/authorize";
  const options = {
    redirect_uri: REDIRECT_URI_DISCORD,
    client_id: discord_clientID,
    state: "goToPerou",
    response_type: "code",
    prompt: "consent",
    scope: [
      "identify"
    ].join(" ")
  };
  return `${rootUrl}?${querystring.stringify(options)}`;
}

router.get("/url", (request, response) => {
  return response.send(get_code());
});

router.get("/", async (req, response) => {
    const code = req.query.code;
    const url = "https://discord.com/api/v8/oauth2/token";
    const data = {
      code,
      client_id: discord_clientID,
      client_secret: discord_secret,
      redirect_uri: REDIRECT_URI_DISCORD,
      grant_type: "authorization_code",
    };
    axios
    .post(url, querystring.stringify(data), {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    })
    .then((res) => {
      response.json(res.data.access_token)
    })
    .catch((error) => {
      console.error(`Failed to fetch auth tokens`, error);
      throw new Error(error);
    });
})

module.exports = router;