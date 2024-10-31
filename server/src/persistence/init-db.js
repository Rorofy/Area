const db = require('./db')
const sql = require('sql-template-strings')

module.exports = {
  initAll() {
    db.query(sql`CREATE TABLE IF NOT EXISTS users (
      id SERIAL NOT NULL,
      email text NOT NULL,
      password text NULL,
      google text NULL,
      discord text NULL,
      reddit text NULL,
      gitlab text NULL,
      messenger text NULL,
      github text NULL,
      twitch text  NULL);`)
    db.query(sql`CREATE TABLE IF NOT EXISTS areas (
      id SERIAL NOT NULL,
      user_id int NOT NULL,
      action text NOT NULL,
      reaction text NOT NULL,
      action_config text NULL,
      reaction_config text NULL);`)
  }
}