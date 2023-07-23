const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');
const bookingsRouter = require('./routers/bookings.router');
const bookRouter = require('./routers/book.router');
const cors = require('cors');

// Import your Bookings model
const Bookings = require('./model/bookings.model'); // Replace this with the correct path to your Bookings model

const multer = require('multer');
const sharp = require('sharp');
const controller = require('./controllers/bookings.controller'); // Import the bookings controller

const storage = multer.memoryStorage();
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5, // 5 MB file size limit
  },
});

const app = express();

app.use(bodyParser.json({ limit: '50mb' }));

// Handle the file upload
app.post('/upload', upload.single('image'), controller.uploadImage);

// Enable CORS with options
app.use(cors({ origin: '*' }));

app.use('/', userRouter);
app.use('/', bookingsRouter);
app.use('/', bookRouter);

module.exports = app;
