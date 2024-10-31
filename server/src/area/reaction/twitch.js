const axios = require('axios')
const {twitch_clientID, twitchExtension_clientID} = require('../../const.json')

async function getMyID(username, token)
{
  let tmp = token;
  if (token.includes("\"")) {
      tmp = token.substring(1, token.length - 1)
  }
  let response = await axios
    .get("https://api.twitch.tv/helix/users?login=" + username, {
      headers: {
        Authorization: `Bearer ${tmp}`,
        'Client-Id': twitch_clientID
      }
    })
  return response.data.data[0].id
}

async function sendChatMessage(text, username, token) {
  let tmp = token;
  if (token.includes("\"")) {
      tmp = token.substring(1, token.length - 1)
  }
  try {
    const id = await getMyID(username, token)
    await axios.post("https://api.twitch.tv/helix/extensions/chat?broadcaster_id=" + id, {
      text,
      extension_id: twitchExtension_clientID,
      extension_version: '0.0.1'
    }, {
      headers: {
        Authorization: `Bearer ${tmp}`,
        'Client-Id': twitchExtension_clientID,
        'Content-Type': 'application/json'
      }
    })
  } catch (e) {
    console.error(e)
  }
}

module.exports.sendChatMessage = sendChatMessage