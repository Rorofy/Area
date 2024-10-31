const express = require('express');

const { Router } = express;
const router = new Router();
const users = require('./db/user.js');
const tokens = require('./db/token.js');
const areas = require('./db/area.js');
const oauth = require('./externalApi/oauth/oauth');
const aboutJSON = require('./about.js');
const apkDownload = require('./downloadApk.js')
const middleware = require('../middleware/security')

router.use('/user', users);
router.use('/oauth', oauth);
router.use('/about.json', aboutJSON);
router.use('/client.apk', apkDownload)
router.use('/token', middleware.checkJWT, tokens);
router.use('/area', middleware.checkJWT, areas);
module.exports = router;