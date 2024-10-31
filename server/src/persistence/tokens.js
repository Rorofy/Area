const sql = require('sql-template-strings');
const bcrypt = require('bcrypt');
const db = require('./db');

module.exports = {
  async set(email, service, token, callback) {
    try {
      let query;
      if (token)
        query = 'UPDATE users SET '+ service + ' = \'' + token + '\' WHERE email = \'' + email + '\';';
      else
        query = 'UPDATE users SET '+ service + ' = \'\' WHERE email = \'' + email + '\';';
      db.query(query).then(() => {
        callback(true)
      }).catch(e => {
        callback(false)
      })
    } catch (error) {
      throw error;
    }
  },
  async find(email, service) {
    const query = 'SELECT '+ service + ' FROM users ' + ' WHERE email = \'' + email + '\';';
    const { rows } = await db.query(query);
    return rows[0][service];
  },
  async findAll(email) {
    const query = 'SELECT * FROM users ' + ' WHERE email = \'' + email + '\';';
    const { rows } = await db.query(query);
    delete rows[0].id
    delete rows[0].email
    delete rows[0].password
    return rows[0];
  },
};