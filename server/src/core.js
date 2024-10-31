const AREA = require('./persistence/areas')
const GOOGLE_ACTION = require('./area/action/google')
const GITHUB_ACTION = require('./area/action/github')
const REDDIT_ACTION = require('./area/action/reddit')
const DISCORD_REACTION = require('./area/reaction/discord')
const TWITCH_ACTION = require('./area/action/twitch')
const ALARM_ACTION = require('./area/action/alarm')
const WATER_ACTION = require('./area/action/water')
const GMAIL_REACTION = require('./area/reaction/gmail')
const TWITCH_REACTION = require('./area/reaction/twitch')
const SMS_REACTION = require('./area/reaction/sms')
const REDDIT_REACTION = require('./area/reaction/reddit')

async function start () {
  const areas = await AREA.findAllOfAll()
  areas.forEach(async (area) => {
    const tokens = await AREA.joinAreaUser(area.user_id)
    let data = {
      message: 'gros zob',
      data: []
    }
    switch (area.action) {
      case 'gmail':
        data = await GOOGLE_ACTION.getMail(tokens[0].google)
        break
      case 'drive':
        data = await GOOGLE_ACTION.getDrive(tokens[0].google)
        break
      case 'calendar':
        data = await GOOGLE_ACTION.getCalendarEvent(tokens[0].google, area.action_config)
        break
      case 'github':
        data = await GITHUB_ACTION.getGithubPush(area.action_config, area.action_config)
        break
      case 'twitch':
        data = await TWITCH_ACTION.getFollowers(tokens[0].twitch, area.action_config)
        break
      case 'reddit':
        data = await REDDIT_ACTION.getFeed(tokens[0].reddit)
        break;
      case 'alarm':
        data = await ALARM_ACTION.getAlarm(area.action_config)
        break;
      case 'water':
        data = await WATER_ACTION.getWaterReminder()
        break;

    }
    if (data.data.length !== 0) {
      switch (area.reaction) {
        case ('discord'):
          DISCORD_REACTION.discordSend(
            area.reaction_config,
            data.message)
          break;
        case ('gmail'):
          GMAIL_REACTION.mailTo(
            area.reaction_config,
            data.message)
          break;
        case ('sms'):
          SMS_REACTION.sendSMS(
            data.message,
            area.reaction_config)
          break;
        case ('reddit'):
          REDDIT_REACTION.alertUser(
            tokens[0].reddit,
            data.message)
          break;
        /* case ('twitch'):
          TWITCH_REACTION.sendChatMessage(`Vous avez une action sur ${area.action}`, area.reaction_config, tokens[0].twitch)
          break */
      }
    }
  });
}

module.exports.start = start;