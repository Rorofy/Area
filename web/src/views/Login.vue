<template>
  <div>
    <v-row align="center" justify="center" class="mt-12">
      <v-col cols="12" sm="8" md="4">
        <v-card elevation-12>
          <v-toolbar flat dark color="primary">
            <v-toolbar-title>Login</v-toolbar-title>
          </v-toolbar>
          <v-text-field label="Email" prepend-icon="mdi-account" class="ma-2" v-model="login"/>
          <v-text-field label="Password" prepend-icon="mdi-lock" type="password" class="mx-2" v-model="password"/>
          <a href="/register" class="ml-5">Register</a>
          <v-card-actions>
            <v-spacer/>
            <v-btn align="right" color="primary" @click="connectGoogle">
              <v-icon>mdi-google</v-icon>
              Google
            </v-btn>
            <v-btn align="right" color="primary" @click="submitForm">Se connecter</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import { api } from '@/consts.json'
export default {
  data: () => {
    return ({
      login: 'mimi',
      password: 'prostatemassage'
    })
  },
  created () {
    if (this.$cookies.get('auth')) {
      this.$router.replace('/dashboard')
    }
  },
  methods: {
    submitForm () {
      this.axios.post(`${api}/user/login`, {
        email: this.login,
        password: this.password
      }).then(response => {
        this.$cookies.set('auth', response.data.jwt, -1)
        this.$toast.bottom(response.data.message)
        this.$router.replace('/dashboard')
      }).catch(e => {
        this.$toast('Incorrect email or password')
      })
    },
    connectGoogle () {
      this.axios.get(`${api}/oauth/google/urlLogin`).then(res => {
        window.location.replace(res.data)
      })
    }
  }
}
</script>
