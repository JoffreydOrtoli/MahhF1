require('dotenv').config();
const express = require('express');
const path = require('path');

const router = require('./app/routers/router.js');

const PORT = process.env.PORT || 3333;
const app = express();

app
    .set('view engine', 'ejs')
    .set('views', 'app/views')
    .use(express.static(path.join(__dirname, '/public')))
    .use(express.urlencoded({ extended: true }))
    .use(router)
    .listen(PORT, () => {
        console.log('Listening on http://localhost:' + PORT);
    });
