const { Router } = require('express');
const router = new Router();
const { gitlab_clientID, gitlab_secret, gitlab_codeVerifier } = require('../../../const.json');
const axios = require('axios');
const CryptoJS = require('crypto-js')
var querystring = require('querystring');

function base64URL(string) {
  return string.toString(CryptoJS.enc.Base64)
}

function generateCodeChallenge(code_verifier) {
  return code_challenge = base64URL(CryptoJS.SHA256(code_verifier))
}

function getGoogleAuthURL() {
  const rootUrl = "https://gitlab.com/oauth/authorize";
  const code_challenge = 'MWJkYzcxNTJmZGI2YzczMDliOTUwMDI2YjUzMDRmZGY1MWM0NTA3YzA1NzIyZTViMjhlMTNlYTQzZDU1MDNiYQ'
  const options = {
    redirect_uri: `http://localhost:8000/oauth/gitlab`,
    client_id: `${gitlab_clientID}`,
    response_type: "code",
    state: 'gros zob',
    scope: [
      'api',
      'read_user',
      'read_api',
      'read_repository',
      'write_repository',
      'read_registry',
      'write_registry',
      'sudo',
      'openid',
      'profile',
      'email'
    ].join(" "),
    code_challenge,
    code_challenge_method: 'S256'
  };
  return `${rootUrl}?${querystring.stringify(options)}`;
}

router.get("/url", (request, response) => {
  return response.send(getGoogleAuthURL());
});

router.get("/", async (req, response) => {
  const code = req.query.code;
  const url = "https://gitlab.com/oauth/token";
  const values = {
    code,
    client_id: gitlab_clientID,
    redirect_uri: 'http://localhost:8000/oauth/gitlab',
    grant_type: "authorization_code",
    code_verifier: gitlab_codeVerifier
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