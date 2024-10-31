<template>
  <div>
    <iframe id="my_iframe" style="display:none;"></iframe>
  </div>
</template>

<script>
import { api } from '@/consts'
export default {
  created () {
    this.axios.get(`${api}/client.apk`, {
      responseType: 'blob'
    }).then(response => {
      const blob = new Blob([response.data], { type: 'application/octet-binary' })
      const link = document.createElement('a')
      link.href = URL.createObjectURL(blob)
      link.download = 'area.apk'
      link.click()
      URL.revokeObjectURL(link.href)
    }).catch(console.error)
  }
}
</script>
