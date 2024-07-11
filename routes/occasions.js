// routes/occasions.js

const express = require('express');
const router = express.Router();
const { addOccasion, removeOccasion } = require('../queries/occasions');

router.post('/add', async (req, res) => {
    try {
        const { occasion } = req.body;
        await addOccasion(occasion);
        res.status(201).send('Occasion added');
    } catch (error) {
        res.status(500).send(error.message);
    }
});

router.delete('/remove', async (req, res) => {
    try {
        const { occasion } = req.body;
        await removeOccasion(occasion);
        res.status(200).send('Occasion removed');
    } catch (error) {
        res.status(500).send(error.message);
    }
});

module.exports = router;
