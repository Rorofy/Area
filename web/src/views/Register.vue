<template>
  <div>
    <v-row align="center" justify="center" class="mt-12">
      <v-col cols="12" sm="8" md="4">
        <v-card elevation-12>
          <v-toolbar flat dark color="primary">
            <v-toolbar-title>Login</v-toolbar-title>
          </v-toolbar>
          <v-text-field placeholder="Luk.grozob@siffredi.it" label="Email" prepend-icon="mdi-account" class="ma-2" v-model="login"/>
          <v-text-field label="Password" prepend-icon="mdi-lock" type="password" class="mx-2" v-model="password"/>
          <v-text-field label="Confirm password" prepend-icon="mdi-lock" type="password" class="mx-2" v-model="confirmPassword"/>
          <a href="/login" class="ml-5">Login</a>
          <v-card-actions>
            <v-spacer/>
            <v-btn align="right" color="primary" @click="submitForm">Register</v-btn>
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
      login: '',
      password: 'prostatemassage',
      confirmPassword: 'prostatemassage'
    })
  },
  created () {
    if (this.$cookies.get('auth')) {
      this.$router.replace('/dashboard')
    }
  },
  methods: {
    submitForm () {
      if (this.password !== this.confirmPassword) {
        this.$toast('Your passwords are not the same')
        return
      }
      this.axios.post(`${api}/user/register`, {
        email: this.login,
        password: this.password
      }).then(response => {
        this.$cookies.set('auth', response.data.jwt, -1)
        this.axios.defaults.headers.common.Authorization = `Bearer ${this.$cookies.get('auth')}`
        this.$toast.bottom(response.data.message)
        this.$router.replace('/dashboard')
      }).catch(e => {
        this.$toast('Email already used')
      })
    }
  }
}
</script>
