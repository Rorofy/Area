const axios = require('axios');
const getNewFeedUrl = "https://oauth.reddit.com/message/unread.json";

async function getFeed(token) {
    try {
        const after = Math.round(Date.now() / 1000) - 60
        let tmp = token;
        if (token.includes("\"")) {
            tmp = token.substring(1, token.length - 1)
        }
        const feed = await axios.get(getNewFeedUrl, {
        headers: {
          Authorization: `Bearer ${tmp}`,
        }
        })
        if (feed.data.kind !== 'Listing') {
            console.log('test1')
            return {
                message: `Fuck.`,
                data: []
            }
        }
        res = feed.data.data.children
        nb = 0;
        for (i in res) {
            if (res[i].data.created_utc >= after)
                nb++;
        }
        if (nb === 0) {
            return {
                message: `You have no friend.`,
                data: []
            }
        } else {
            return {
                message: 'Vous avez ' + nb + ' nouveau(x) message(s) privé(s)',
                data: feed
            }
        }
    } catch (e) {
      console.error(e)
    }
}

module.exports.getFeed = getFeed;
