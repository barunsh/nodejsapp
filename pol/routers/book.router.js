const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controller.js');
const PropertyRouter = require('./property.router');
const BookController = require('../controllers/book.controller.js');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.post('/createBook', BookController.createBook);
// router.use('/properties', PropertyRouter);

module.exports = router;
