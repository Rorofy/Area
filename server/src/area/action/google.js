const axios = require('axios');

const getMailUrl = 'https://www.googleapis.com/gmail/v1/users/me/messages?q=in:inbox after:'
const getMailObjectUrl = 'https://gmail.googleapis.com/gmail/v1/users/me/messages/'
const getDriveUrl = 'https://www.googleapis.com/drive/v3/files'
const getCalendarIdUrl = 'https://www.googleapis.com/calendar/v3/users/me/calendarList'
const getCalendarEventsUrl = 'https://www.googleapis.com/calendar/v3/calendars/'

function getAllSubjects(id, token) {
  return axios.get(getMailObjectUrl + id, {
    headers: {
      Authorization: `Bearer ${token}`
    }
  })
}

async function getMail(token) {
  try {
    const after = Math.round(Date.now() / 1000) - 60
    const mails = await axios.get(getMailUrl + after, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    const promises = []
    if (mails.data.resultSizeEstimate === 0) {
      return {
        message: `TALIBAN AIRLINES`,
        data: []
      }
    }
    mails.data.messages.forEach(async (message) => {
      promises.push(getAllSubjects(message.id, token))
    })
    values = await Promise.all(promises)
    const res = values.map(val => {
      return val.data.payload.headers.filter(header => header.name === 'Subject')[0].value + ' from: ' + val.data.payload.headers.filter(header => header.name === 'From')[0].value.split('<')[0]
    })
    console.log(res)
    return {
      message: `Vous avez ${res.length} nouveau(x) mail(s): \n\t- ` + res.join('\n\t- '),
      data: res
    }
  } catch (e) {
    console.error(e)
  }
}

function getDriveTime(id, token) {
  return axios.get(`${getDriveUrl}/${id}?fields=modifiedTime,name`, {
    headers: {
      Authorization: `Bearer ${token}`
    }
  })
}

async function getDrive(token) {
  try {
    const after = Date.now()
    const drive = await axios.get(getDriveUrl, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    const promises = []
    if (drive.data.files.length === 0) {
      return []
    }
    drive.data.files.forEach(async (file) => {
      promises.push(getDriveTime(file.id, token))
    })
    values = await Promise.all(promises)
    const res = []
    values.every(file => {
      if (after - Date.parse(file.data.modifiedTime) > 60000) {
        return false
      }
      res.push(file.data.name)
      return true
    })
    return {
      message: `Vous avez ${res.length} ficher(s) modifié(s) dans votre Drive, les fichiers: \n\t- ` + res.join('\n\t- '),
      data: res
    }
  } catch (e) {
    console.error(e)
  }
}

async function getCalendarId(token) {
  const res = await axios.get(getCalendarIdUrl, {
    headers: {
      Authorization: `Bearer ${token}`
    }
  })
  return res.data.items[0].id
}

async function getCalendarEvent(token, time) {
  const id = await getCalendarId(token)
  const date = Date.now() + time * 60 * 1000
  const timeMin = new Date(date).toISOString()
  try {
    const events = await axios.get(getCalendarEventsUrl + id + '/events?timeMin=' + timeMin, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    if (events.data.items.length === 0) {
      return []
    }
    let res = events.data.items.filter(event => {
      const tmpDate = new Date(event.start.dateTime)
      tmpDate.setMinutes(tmpDate.getMinutes() - time)
      const tmpString = tmpDate.toISOString().slice(0,16)
      if (tmpString === new Date().toISOString().slice(0,16)) {
        return event.summary
      }
    })
    res = res.map(event => {
      return event.summary
    })
    return {
      message: `Vous avez ${res.length} évènement(s) qui vont bientôt arriver: \n\t- ` + res.join('\n\t- '),
      data: res
    }
  } catch (e) {
    console.error(e)
  }
}

module.exports.getMail = getMail;
module.exports.getDrive = getDrive;
module.exports.getCalendarEvent = getCalendarEvent;
