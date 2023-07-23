const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controller.js');
const BookingsRouter = require('./bookings.router');
const BookController = require('../controllers/book.controller.js');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.post('/createBook', BookController.createBook);
// router.use('/bookings', BookingsRouter);

module.exports = router;
