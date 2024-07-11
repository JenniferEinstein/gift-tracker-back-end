const express = require('express');
const router = express.Router();
const { addRelationship, removeRelationship } = require('../queries/relationships');

// Route to add a new relationship
router.post('/add', async (req, res) => {
    try {
        const { relationship } = req.body;
        await addRelationship(relationship);
        res.status(201).send('Relationship added');
    } catch (error) {
        res.status(500).send(error.message);
    }
});

// Route to remove a relationship
router.delete('/remove', async (req, res) => {
    try {
        const { relationship } = req.body;
        await removeRelationship(relationship);
        res.status(200).send('Relationship removed');
    } catch (error) {
        res.status(500).send(error.message);
    }
});

module.exports = router;
