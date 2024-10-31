<template>
  <v-card outlined class="card">
    <v-select outlined :items="actionItems" v-model="action" @change="changeAction"></v-select>
    <v-text-field v-if="action === 'calendar' || action === 'github' || action === 'twitch'" :label="actionLabel" @change="changeActionConfig" v-model="action_config"></v-text-field>
    <v-time-picker height="250" width="250" v-model="action_config" v-if="action === 'alarm'" @change="changeActionConfig"></v-time-picker>
    <img :src="actionImage" alt="actionImg" v-if="action !== 'alarm'" />
    <v-icon x-large>fa fa-arrow-down</v-icon>
    <img :src="reactionImage" alt="reactionImg"/>
    <v-text-field v-if="reaction === 'discord' || reaction === 'gmail' || reaction === 'twitch' || reaction === 'sms'" :label="reactionLabel" @change="changeReactionConfig" v-model="reaction_config"></v-text-field>
    <v-select outlined :items="reactionItems" v-model="reaction" @change="changeReaction"></v-select>
    <v-btn color="red" @click="deleteArea">
      <v-icon>mdi-delete</v-icon>
      Delete
    </v-btn>
  </v-card>
</template>

<script>
import discordImage from '@/assets/discord.png'
import redditImage from '@/assets/reddit.png'
import calendarImage from '@/assets/calendar.png'
import githubImage from '@/assets/github.png'
import gmailImage from '@/assets/gmail.png'
import driveImage from '@/assets/drive.png'
import twitchImage from '@/assets/twitch.png'
import smsImage from '@/assets/sms.png'
import alarmImage from '@/assets/alarm.png'
import waterImage from '@/assets/water.png'
import { api } from '@/consts.json'

export default {
  props: ['action', 'reaction', 'id', 'action_config', 'reaction_config'],
  data: () => {
    return ({
      menu: false,
      actionImage: '',
      reactionImage: '',
      actionLabel: '',
      reactionLabel: '',
      actionItems: [
        { text: 'Gmail - receive mail', value: 'gmail' },
        { text: 'Calendar - event incoming', value: 'calendar' },
        { text: 'Reddit - receive message', value: 'reddit' },
        { text: 'Github - push on repo', value: 'github' },
        { text: 'Twitch - new followers', value: 'twitch' },
        { text: 'Drive - receive answer', value: 'drive' },
        { text: 'Alarm - Set a daily alarm', value: 'alarm' },
        { text: 'Water - Reminds you to drink water every hour', value: 'water' }
      ],
      reactionItems: [
        { text: 'Gmail sends you a mail', value: 'gmail' },
        { text: 'Reddit sends you a message', value: 'reddit' },
        { text: 'Discord sends you a message', value: 'discord' },
        { text: 'Sends a sms', value: 'sms' }
      ]
    })
  },
  created () {
    this.changeActionImage()
    this.changeReactionImage()
  },
  methods: {
    changeActionImage () {
      switch (this.action) {
        case 'reddit':
          this.actionImage = redditImage
          break
        case 'gmail':
          this.actionImage = gmailImage
          break
        case 'calendar':
          this.actionImage = calendarImage
          this.actionLabel = 'Time before reaction in min'
          break
        case 'github':
          this.actionImage = githubImage
          this.actionLabel = 'Github repo'
          break
        case 'drive':
          this.actionImage = driveImage
          break
        case 'twitch':
          this.actionImage = twitchImage
          this.actionLabel = 'Your streamer name'
          break
        case 'water':
          this.actionImage = waterImage
          break
        case 'alarm':
          this.actionImage = alarmImage
          break
      }
    },
    changeReactionImage () {
      switch (this.reaction) {
        case 'discord':
          this.reactionImage = discordImage
          this.reactionLabel = 'Webhook url'
          break
        case 'reddit':
          this.reactionImage = redditImage
          break
        case 'gmail':
          this.reactionImage = gmailImage
          this.reactionLabel = 'Mail Adress'
          break
        case 'sms':
          this.reactionImage = smsImage
          this.reactionLabel = 'Phone number'
          break
      }
    },
    changeAction () {
      this.axios.patch(`${api}/area/update/${this.id}`, {
        key: 'action',
        value: this.action
      }, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        this.changeActionImage()
      })
    },
    changeReaction () {
      this.axios.patch(`${api}/area/update/${this.id}`, {
        key: 'reaction',
        value: this.reaction
      }, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        this.changeReactionImage()
      })
    },
    deleteArea () {
      this.$emit('delete', this.id)
    },
    changeReactionConfig (reaction) {
      this.axios.patch(`${api}/area/update/${this.id}`, {
        key: 'reaction_config',
        value: this.reaction_config
      }, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        console.log(res.data)
      })
    },
    changeActionConfig (action) {
      this.axios.patch(`${api}/area/update/${this.id}`, {
        key: 'action_config',
        value: this.action_config
      }, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        console.log(res.data)
      })
    }
  }
}
</script>

<style>
.card {
display: flex;
flex-direction: column;
width: 250px;
text-align: center;
}
</style>
