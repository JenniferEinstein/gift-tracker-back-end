// queries/relationships.js

const db = require('../db');

const addRelationship = async (relationship) => {
    const query = 'INSERT INTO relationships (relationship) VALUES ($1)';
    await db.query(query, [relationship]);
};

const removeRelationship = async (relationship) => {
    const query = `
        DELETE FROM relationships 
        WHERE relationship = $1 AND NOT EXISTS (
            SELECT 1 FROM recipients WHERE relationship_id = (SELECT relationship_id FROM relationships WHERE relationship = $1)
        )`;
    await db.query(query, [relationship]);
};

module.exports = {
    addRelationship,
    removeRelationship,
};
