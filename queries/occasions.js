// queries/occasions.js

const db = require('../db');

const addOccasion = async (occasion) => {
    const query = 'INSERT INTO occasions (occasion) VALUES ($1)';
    await db.query(query, [occasion]);
};

const removeOccasion = async (occasion) => {
    const query = `
        DELETE FROM occasions 
        WHERE occasion = $1 AND NOT EXISTS (
            SELECT 1 FROM gifts WHERE occasion_id = (SELECT occasion_id FROM occasions WHERE occasion = $1)
        )`;
    await db.query(query, [occasion]);
};

module.exports = {
    addOccasion,
    removeOccasion,
};
