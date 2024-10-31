import Vue from 'vue'
import App from './App.vue'
import router from './router'
import vuetify from './plugins/vuetify'
import axios from 'axios'
import VueAxios from 'vue-axios'
import 'vue2-toast/lib/toast.css'
import Toast from 'vue2-toast'
Vue.config.productionTip = false
Vue.use(require('vue-cookies'))
Vue.use(VueAxios, axios)
Vue.use(Toast)

new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')
