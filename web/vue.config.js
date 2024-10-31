const SimpleProgressWebpackPlugin = require('simple-progress-webpack-plugin')

module.exports = {
  transpileDependencies: [
    'vuetify'
  ],
  configureWebpack: {
    plugins: [
      new SimpleProgressWebpackPlugin({
        format: 'compact'
      })
    ]
  },
  devServer: {
    progress: false
  }
}
