<template>
  <v-app style="background-color: #242424">
    <v-app-bar
      app
      color="#323232"
      dark
    >
    <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>
    <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
      dark
    >
      <v-list dense>
        <v-list-item
          v-for="item in items"
          :key="item.title"
          link
          :href="item.route"
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: 'App',
  data: () => ({
    drawer: false,
    items: [
      { title: 'Home', icon: 'mdi-home', route: '/dashboard' },
      { title: 'OAuth2', icon: 'mdi-account-details', route: '/oauth' },
      { title: 'Download APK', icon: 'mdi-cellphone-arrow-down', route: '/client.apk' }
    ]
  })
}
</script>
