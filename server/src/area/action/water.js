async function getWaterReminder() {
  const now = new Date().toLocaleTimeString().slice(2, 4)
  if (now === '00') {
    return {
      message: "Buvez de l'eau s'il vous plaît",
      data: ['Dans 20-30 ans y\'en aura plus']
    }
  }
  return {
    message: "",
    data: []
  }
}

module.exports.getWaterReminder = getWaterReminder;