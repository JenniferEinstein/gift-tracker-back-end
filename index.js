// file: index.js

// DEPENDENCIES
const express = require('express');
const cors  = require('cors');
const app = express();

app.use(cors());


// ROUTES
app.get('/', (req, res) => {
    res.send("This is a gift tracker server");
});


//LISTEN
app.listen(8081, () => {
    console.log('the server is listening on port 8081')
});