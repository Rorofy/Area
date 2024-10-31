const { Router } = require('express');
const router = new Router();
const { twitch_clientID, twitch_secret, jwt_key } = require('../../../const.json');
const jwt = require('jsonwebtoken');
const axios = require('axios');
var querystring = require('querystring');

function getTwitchAuthURL() {
  const rootUrl = "https://id.twitch.tv/oauth2/authorize";
  const options = {
    redirect_uri: `http://localhost:8000/oauth/twitch`,
    client_id: `${twitch_clientID}`,
    response_type: "code",
    scope: [
      "channel:read:polls",
      "user:read:email"
    ]
  };
  return `${rootUrl}?${querystring.stringify(options)}`;
}

router.get("/url", (request, response) => {
  return response.send(getTwitchAuthURL());
});

router.get("/", async (req, response) => {
  const code = req.query.code;
  const url = "https://id.twitch.tv/oauth2/token";
  const values = {
    code,
    client_id: twitch_clientID,
    client_secret: twitch_secret,
    redirect_uri: 'http://localhost:8000/oauth/twitch',
    grant_type: "authorization_code",
  };
  axios
    .post(url, querystring.stringify(values), {
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