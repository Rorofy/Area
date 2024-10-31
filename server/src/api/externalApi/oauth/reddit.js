const { Router } = require('express');
const router = new Router();
const { reddit_clientID, reddit_secret } = require('../../../const.json');
const axios = require('axios');
var querystring = require('querystring');

function getRedditAuthURL() {
  const rootUrl = "https://www.reddit.com/api/v1/authorize";
  const options = {
    redirect_uri: `http://localhost:8000/oauth/reddit`,
    client_id: `${reddit_clientID}`,
    response_type: "code",
    scope: "*",
    duration: 'permanent',
    state: 'ouais zebi'
  };
  return `${rootUrl}?${querystring.stringify(options)}`;
}

router.get("/url", (request, response) => {
  return response.send(getRedditAuthURL());
});

router.get("/", async (req, response) => {
  const code = req.query.code;
  const url = "https://www.reddit.com/api/v1/access_token";
  const values = {
    code,
    redirect_uri: 'http://localhost:8000/oauth/reddit',
    grant_type: "authorization_code",
  };
  const credentials = Buffer.from(`${reddit_clientID}:${reddit_secret}`).toString("base64")
  axios
    .post(url, querystring.stringify(values), {
      headers: {
        "content-type": "application/x-www-form-urlencoded",
        "Authorization": `Basic ${credentials}`
      },
    })
    .then((res) => {
      response.json(res.data.access_token)
    })
    .catch((error) => {
      console.error(`Failed to fetch auth tokens`, error);
    });
})

module.exports = router;