<template>
  <div></div>
</template>

<script>
import { api } from '@/consts.json'
export default {
  created () {
    const code = this.$route.query.code
    this.axios.get(`${api}/oauth/google/login?code=${code}`).then(res => {
      this.$cookies.set('auth', res.data.jwt, -1)
      this.$toast.bottom(res.data.message)
      this.$router.replace('/dashboard')
    })
  }
}
</script>
