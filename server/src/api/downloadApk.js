const { Router } = require('express');
const router = new Router();

router.get("/", (req, res) => {
  const file = '/usr/share/data/app-release.apk'
  res.sendFile(file)
})

module.exports = router;