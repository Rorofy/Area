const { Router } = require('express');
const router = new Router();
const google = require('./google');
const discord = require('./discord');
const twitch = require('./twitch');
const reddit = require('./reddit');
// const gitlab = require('./gitlab');
const messenger = require('./messenger');
const github = require('./github');

router.use('/google', google);
router.use('/discord', discord);
router.use('/twitch', twitch);
router.use('/reddit', reddit);
// router.use('/gitlab', gitlab);
router.use('/messenger', messenger);
router.use('/github', github);
module.exports = router;