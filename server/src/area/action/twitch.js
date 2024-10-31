const axios = require('axios')
const {twitch_clientID} = require('../../const.json')

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

async function getFollowers(token, username) {
  let tmp = token;
  if (token.includes("\"")) {
      tmp = token.substring(1, token.length - 1)
  }
  try {
    const userID = await getMyID(username, token)
    const poll = await axios.get('https://api.twitch.tv/helix/users/follows?to_id=' + userID, {
      headers: {
        Authorization: `Bearer ${tmp}`,
        'Client-Id': twitch_clientID
      }
    })
    let after = new Date()
    after.setMinutes(after.getMinutes() - 1)
    const newFollowers = poll.data.data.filter(follower => follower.followed_at.slice(0, 16) === after.toISOString().slice(0, 16))
    let tmp1 = (poll.data.data[0].followed_at.slice(0, 16))
    let tmp2 = (after.toISOString().slice(0, 16))
    const res = newFollowers.map(follower => {
      return follower.from_name
    })
    return {
      message: `Vous avez ${res.length} nouveau(x) follower(s):\n\t- ` + res.join('\n\t-'),
      data: res
    }
  } catch (e) {
    console.error(e)
  }
}

module.exports.getFollowers = getFollowers