<template>
  <div class="accounts">
    <v-card class="card" v-for="service in services" :key="service.service">
      <v-card-title>
        <h2>
          {{service.service.charAt(0).toUpperCase() + service.service.slice(1)}}
        </h2>
        <v-spacer></v-spacer>
        <v-icon x-large color="success" v-if="service.connected">mdi-check-underline</v-icon>
        <v-icon x-large color="error" v-if="!service.connected">mdi-close</v-icon>
      </v-card-title>
      <img :src="service.image" :alt="service.service">
      <v-btn class="mb-4" v-if="!service.connected" @click="connect(service.service)">Connect</v-btn>
      <v-btn class="mb-4" v-if="service.connected" @click="disconnect(service.service)">Disconnect</v-btn>
    </v-card>
  </div>
</template>

<script>
import google from '@/assets/google.png'
import discord from '@/assets/discord.png'
import github from '@/assets/github.png'
import reddit from '@/assets/reddit.png'
import twitch from '@/assets/twitch.png'
import messenger from '@/assets/messenger.png'
import { api } from '@/consts.json'
export default {
  data: () => {
    return ({
      services: [
        {
          service: 'google',
          connected: false,
          image: google
        },
        {
          service: 'reddit',
          connected: false,
          image: reddit
        },
        {
          service: 'discord',
          connected: false,
          image: discord
        },
        {
          service: 'github',
          connected: false,
          image: github
        },
        {
          service: 'twitch',
          connected: false,
          image: twitch
        },
        {
          service: 'messenger',
          connected: false,
          image: messenger
        }
      ]
    })
  },
  created () {
    if (!this.$cookies.get('auth')) {
      this.$router.replace('/login')
    }
    this.checkConnected()
  },
  methods: {
    updateService (service, state) {
      const index = this.services.findIndex(element => element.service === service)
      this.services[index].connected = state
    },
    checkConnected () {
      this.axios.get(`${api}/token/getAll`, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        if (res.data.google) {
          this.updateService('google', true)
        }
        if (res.data.twitch) {
          this.updateService('twitch', true)
        }
        if (res.data.messenger) {
          this.updateService('messenger', true)
        }
        if (res.data.discord) {
          this.updateService('discord', true)
        }
        if (res.data.reddit) {
          this.updateService('reddit', true)
        }
        if (res.data.github) {
          this.updateService('github', true)
        }
      })
    },
    connect (service) {
      this.axios.get(`${api}/oauth/${service}/url`).then(res => {
        window.location.replace(res.data)
      })
    },
    disconnect (service) {
      this.axios.delete(`${api}/token/delete/${service}`, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(res => {
        this.axios.get(`${api}/token/get?service=${service}`, {
          headers: {
            Authorization: this.$cookies.get('auth')
          }
        }).then((token) => {
          if (token) {
            this.updateService(service, false)
            this.checkConnected(service)
          }
        })
      })
    }
  }
}
</script>

<style scoped>
.accounts {
display: flex;
flex-wrap: wrap;
text-align: center;
}
.card {
  width: 18%;
  height: 50%;
  margin: auto;
  margin-top: 20px;
}
.text {
  text-align: center;
  text-justify: center;
}
</style>
