const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controller.js');
const BookingsRouter = require('./bookings.router');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.use('/bookings', BookingsRouter);
router.get('/getuser' , UserController.getUser);
// router.put('/updateuser:userId' , UserController.updateUser);
// router.put('/updateuser/:userId', UserController.updateUser);
// router.put('/updateuser:userId', UserController.updateUser);
router.put('/updateuser/:userId', UserController.updateUser);


// router.use('/userDetails', UserController.userDetails);

module.exports = router;
