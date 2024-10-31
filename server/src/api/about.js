const { Router } = require('express');
const router = new Router();

router
  .get("/", (req, res) => {
    console.log(req.headers)
    res.json({
      "client": {
          "host": req.headers['host']
      },
      "server": {
          "current_time": Date.now(),
          "services": [
              {
                  "name": "github",
                  "actions": [
                      {
                          "name": "star repo",
                          "description": "Someone stars the user's repository."
                      }
                  ]
              },
              {
                  "name": "discord",
                  "actions": [
                      {
                          "name": "new direct message",
                          "description": "A new direct message is sent to you"
                      }
                  ]
              },
              {
                  "name": "Google",
                  "actions": [
                      {
                          "name": "receive a mail",
                          "description": "Receive a mail"
                      },
                      {
                          "name": "Event incoming",
                          "description": "Google calendar event incoming"
                      }
                  ],
                  "reactions": [
                      {
                          "name": "send a mail",
                          "description": "Send a mail"
                      }
                  ]
              },
              {
                  "name": "Reddit",
                  "actions": [
                      {
                          "name": "new direct message",
                          "description": "A new direct message is sent to you"
                      }
                  ],
                  "reactions": [
                      {
                          "name": "send a message",
                          "description": "send a reddit message"
                      }
                  ]
              },
              {
                  "name": "Twitch",
                  "actions": [
                      {
                          "name": "New Follower",
                          "description": "Activates when a change occurs with your followers"
                      }
                  ]
              },
              {
                  "name" : "Hydration",
                  "actions" : [
                      {
                          "name" : "drink water",
                          "description" : "Reminds you to drink water."
                      }
                  ]
              },
              {
                  "name" : "Alarm",
                  "actions" : [
                      {
                          "name" : "Alarm",
                          "description" : "Daily Alarm at the same set time"
                      }
                  ]
              }
          ]
      }
  })
  })

module.exports = router;