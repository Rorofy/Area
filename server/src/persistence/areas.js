const sql = require('sql-template-strings');
const db = require('./db');

module.exports = {
  async create(action, reaction, actionConfig,reactionConfig, user_id) {
    try {
      const { rows } = await db.query(sql`
      INSERT INTO areas (user_id, action, reaction, action_config, reaction_config)
        VALUES (${user_id}, ${action}, ${reaction}, ${actionConfig}, ${reactionConfig})
        RETURNING id;
      `);
      const [area] = rows;
      return area;
    } catch (error) {
      if (error.constraint === 'users_email_key') {
        return null;
      }
      throw error;
    }
  },
  async find(id) {
    const { rows } = await db.query(sql`
    SELECT * FROM areas WHERE id=${id};
    `);
    return rows[0];
  },
  async findAll(user_id) {
    const { rows } = await db.query(sql`
    SELECT * FROM areas WHERE user_id=${user_id};
    `);
    return rows;
  },
  async delete(id) {
    const { rows } = await db.query(sql`
    DELETE FROM areas WHERE id = ${id}
    `)
  },
  async update(id, col, val) {
    const query = 'UPDATE areas SET '+ col + ' = \'' + val + '\' WHERE id = ' + id + ';';
    await db.query(query);
  },
  async findAllOfAll() {
    const { rows } = await db.query(sql`
    SELECT * FROM areas;`)
    return rows;
  },
  async joinAreaUser(user_id) {
    const { rows } = await db.query(sql`
    SELECT google, discord, reddit, gitlab, messenger, github, twitch FROM areas
    INNER JOIN users ON areas.user_id = users.id
    WHERE areas.user_id = ${user_id};`)
    return rows;
  }
};