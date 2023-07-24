const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');
const propertyRouter = require('./routers/property.router');
const bookRouter = require('./routers/book.router');
const cors = require('cors');

// Import your Property model
const Property = require('./model/property.model'); // Replace this with the correct path to your property model

const upload = require('./middleware/multer.js'); // Import the multer middleware from the new file
const propertyController = require('./controllers/property.controller'); // Import the property controller from the new file

const app = express();

app.use(bodyParser.json({ limit: '50mb' }));

// Handle the file upload using the multer middleware
app.post('/upload', upload.single('image'), propertyController.uploadImage);

// Enable CORS with options
app.use(cors({ origin: '*' }));

app.use('/', userRouter);
app.use('/', propertyRouter);
app.use('/', bookRouter);

module.exports = app;
