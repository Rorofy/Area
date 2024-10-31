const { Router } = require('express');
const router = new Router();
const { github_clientID, github_secret } = require('../../../const.json');
const jwt = require('jsonwebtoken');
const axios = require('axios');
var querystring = require('querystring');

function getGithubAuthUrl() {
  const rootUrl = "https://github.com/login/oauth/authorize";
  const options = {
    client_id: `${github_clientID}`,
    redirect_uri: `http://localhost:8000/oauth/github`,
    //response_type: "code",
    scope: [
      'repo',
      'user',
      'notifications'
    ].join(" ")
  };
  return `${rootUrl}?${querystring.stringify(options)}`;
}

router.get("/url", (request, response) => {
  return response.send(getGithubAuthUrl());
});

router.get("/", async (req, response) => {
  const code = req.query.code;
  const url = "https://github.com/login/oauth/access_token";
  const values = {
    code,
    client_id: github_clientID,
    client_secret: github_secret,
    redirect_uri: 'http://localhost:8000/oauth/github',
    grant_type: "authorization_code",
  };
  axios
    .post(url, querystring.stringify(values), {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
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