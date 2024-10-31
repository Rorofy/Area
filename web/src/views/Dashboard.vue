<template>
  <div>
    <v-dialog v-model="dialog" max-width="600px" @click:outside="clearDialog">
      <template v-slot:activator="{ on, attrs }">
        <div v-on="on" v-bind="attrs" class="float">
          <i class="fa fa-plus my-float" style="margin-top: 18px"></i>
        </div>
      </template>
      <v-card>
        <div style="display: flex; flex-direction: row; justify-content: space-between; margin: auto;">
          <div class="col">
              <img :src="actionImage" alt="actionImg" class="image" v-if="action !== 'alarm'"/>
              <v-time-picker height="250" width="250" v-model="action_config" v-if="action === 'alarm'"></v-time-picker>
              <v-select outlined :items="actionItems" v-model="action" @change="changeAction" class="select"></v-select>
              <v-text-field v-if="action === 'calendar' || action === 'github' || action === 'twitch'" :label="actionLabel" v-model="action_config"></v-text-field>
          </div>
          <div class="col">
            <img :src="reactionImage" alt="reactionImg" class="image"/>
            <v-select outlined :items="reactionItems" v-model="reaction" @change="changeReaction" class="select"></v-select>
            <v-text-field v-if="reaction === 'discord' || reaction === 'gmail' || reaction === 'sms'" :label="reactionLabel" v-model="reaction_config"></v-text-field>
          </div>
        </div>
        <v-card-actions style="display: flex; flex-direction: row">
          <v-spacer></v-spacer>
          <v-btn color="#0C9" @click="addAREA">Add</v-btn>
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <div style="display: flex; flex-wrap: wrap;">
      <Widget v-for="area in areas" @delete="deleteAREA" :key="area.id" :id="area.id" :action="area.action" :reaction="area.reaction" :action_config="area.action_config" :reaction_config="area.reaction_config" style="margin: 10px"></Widget>
    </div>
  </div>
</template>

<script>
import Widget from '../components/widget.vue'
import discordImage from '@/assets/discord.png'
import redditImage from '@/assets/reddit.png'
import calendarImage from '@/assets/calendar.png'
import githubImage from '@/assets/github.png'
import gmailImage from '@/assets/gmail.png'
import driveImage from '@/assets/drive.png'
import twitchImage from '@/assets/twitch.png'
import actionImage from '@/assets/action.png'
import reactionImage from '@/assets/reaction.png'
import smsImage from '@/assets/sms.png'
import alarmImage from '@/assets/alarm.png'
import waterImage from '@/assets/water.png'
import { api } from '@/consts.json'

export default {
  components: {
    Widget
  },
  data: () => {
    return ({
      areas: [],
      dialog: false,
      actionImage: actionImage,
      reactionImage: reactionImage,
      actionLabel: '',
      reactionLabel: '',
      action_config: '',
      reaction_config: '',
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
      ],
      action: '',
      reaction: ''
    })
  },
  created () {
    if (!this.$cookies.get('auth')) {
      this.$router.replace('/login')
    }
    this.getAREA()
  },
  methods: {
    deleteAREA (id) {
      this.axios.delete(`${api}/area/delete/${id}`, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        this.$toast.bottom(res.data.message)
        this.getAREA()
      })
    },
    getAREA () {
      this.axios.get(`${api}/area/getAll`, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        this.areas = res.data.areas
      })
    },
    addAREA () {
      if ((this.action_config === '' && (this.action === 'calendar' || this.action === 'github' || this.action === 'twitch' || this.action === 'alarm')) ||
      (this.reaction_config === '' && (this.reaction === 'discord' || this.reaction === 'gmail' || this.reaction === 'sms'))) {
        this.$toast.bottom('Missing field(s)')
      } else {
        this.axios.post(`${api}/area/create`, {
          action: this.action,
          reaction: this.reaction,
          action_config: this.action_config,
          reaction_config: this.reaction_config
        }, {
          headers: {
            Authorization: this.$cookies.get('auth')
          }
        }).then(res => {
          this.$toast.bottom(res.data.message)
          this.getAREA()
        })
        this.clearDialog()
      }
    },
    clearDialog () {
      this.dialog = false
      this.action = ''
      this.reaction = ''
      this.action_config = ''
      this.reaction_config = ''
      this.actionImage = actionImage
      this.reactionImage = reactionImage
    },
    changeAction () {
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
    changeReaction () {
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
    }
  }
}
</script>

<style scoped>
.float{
position: fixed;
width: 60px;
height: 60px;
bottom: 40px;
right: 40px;
background-color: #0C9;
color: #FFF;
border-radius: 50px;
text-align: center;
box-shadow:  2px 2px 3px #999;
z-index: 2;
}

.select {
  max-width: 250px;
}
</style>
