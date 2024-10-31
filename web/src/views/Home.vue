<template>
  <div>
    <v-container justify-center align-center>
      <v-row justify="center" align="end" class="mt-12">
        <v-spacer></v-spacer>
        <a href="login" class="myButton">Log in</a>
        <v-spacer></v-spacer>
        <a href="register" class="myButton">Register</a>
        <v-spacer></v-spacer>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { api } from '@/consts.json'
export default {
  name: 'Home',
  data () {
    return {
    }
  },
  created () {
    if (this.$cookies.get('auth')) {
      this.$router.replace('/dashboard')
    }
  },
  methods: {
    downloadApk () {
      this.axios.get(`${api}/client.apk`)
    }
  }
}
</script>

<style scoped>

  .myButton {
    background-color:#bfa2db;
    border-radius:42px;
    border:2px solid #7f7c82;
    display:inline-block;
    cursor:pointer;
    color:#ffffff;
    font-family:Arial;
    font-size:20px;
    padding:20px 53px;
    text-decoration:none;
    margin-bottom: 12px;
  }
  .myButton:hover {
    background-color: #7f7c82;
  }
  .myButton:active {
    position:relative;
    top:1px;
  }
  main {
    text-align: center;
  }

</style>
