<template>
  <div></div>
</template>

<script>
import { api } from '@/consts.json'
export default {
  created () {
    const code = this.$route.query.code.slice(-2) === '#_' ? this.$route.query.code.slice(0, -2) : this.$route.query.code
    this.axios.get(`${api}/oauth/${this.$route.params.service}?code=${code}`).then(res => {
      this.axios.post(`${api}/token/set`, {
        service: this.$route.params.service,
        token: res.data
      }, {
        headers: {
          Authorization: this.$cookies.get('auth')
        }
      }).then(() => {
        this.$router.replace('/oauth')
      })
    })
  }
}
</script>
