const sql = require('sql-template-strings');
const bcrypt = require('bcrypt');
const db = require('./db');

module.exports = {
  async create(email, password = '') {
    try {
      const hashedPassword = await bcrypt.hash(password, 10);
      const { rows } = await db.query(sql`
      INSERT INTO users (email, password)
        VALUES (${email}, ${hashedPassword})
        RETURNING id, email;
      `);
      const [user] = rows;
      return user;
    } catch (error) {
      if (error.constraint === 'users_email_key') {
        return null;
      }
      throw error;
    }
  },
  async find(email) {
    const { rows } = await db.query(sql`
    SELECT * FROM users WHERE email=${email} LIMIT 1;
    `);
    return rows[0];
  },
  async connect(email, password, callback) {
    const { rows } = await db.query(sql`
      SELECT * FROM users
      WHERE email = ${email}
      LIMIT 1
    `)
    if (rows.length == 0) {
      callback({ code: 'no email', user: { id: -1, email: '' } })
    }
    bcrypt.compare(password, rows[0].password, (err, result) => {
      if (result === true) {
        callback({ code: 'valid', user: { id: rows[0].id, email: rows[0].email } })
      } else {
        callback({ code: 'invalid', user: { id: -1, email: '' } })
      }
    })
  }
};