import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('../views/Dashboard.vue')
  },
  {
    path: '/oauth',
    name: 'OAuth',
    component: () => import('../views/OAuth.vue')
  },
  {
    path: '/oauth/:service',
    name: 'OAuthGoogle',
    component: () => import('../oauth/redirect.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/Register.vue')
  },
  {
    path: '/login/google',
    name: 'Login Google',
    component: () => import('../oauth/GoogleLogin.vue')
  },
  {
    path: '/client.apk',
    name: 'Luk@grozob',
    component: () => import('../views/apk.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
