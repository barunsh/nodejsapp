const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');
const bookingsRouter = require('./routers/bookings.router');
const bookRouter = require('./routers/book.router');



const cors = require('cors');

const app = express();

app.use(bodyParser.json());



app.use('/', userRouter);
app.use('/', bookingsRouter);

// Enable CORS with options
app.use(cors({ origin: '*' }));

module.exports = app;
