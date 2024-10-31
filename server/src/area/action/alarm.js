function tConvert (time) {
  time = time.toString ().match (/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time];

  if (time.length > 1) {
    time = time.slice (1);
    time[5] = +time[0] < 12 ? ' AM' : ' PM';
    time[0] = +time[0] % 12 || 12;
  }
  return time.join ('');
}

function getAlarm(time) {
  const now = new Date()
  now.setHours(now.getHours() + 1)
  now.setSeconds(0)
  if (now.toLocaleTimeString() === tConvert(time+':00')) {
    return {
      message: "Il est " + time,
      data: ['Testicule massage']
    }
  }
  return {
    message: "PENDANT 2 HEURES",
    data: []
  }
}

module.exports.getAlarm = getAlarm;