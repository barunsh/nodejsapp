const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controller.js');
const PropertyRouter = require('./property.router');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.use('/properties', PropertyRouter);
router.get('/getuser' , UserController.getUser);
// router.put('/updateuser:userId' , UserController.updateUser);
// router.put('/updateuser/:userId', UserController.updateUser);
// router.put('/updateuser:userId', UserController.updateUser);
router.put('/updateuser/:userId', UserController.updateUser);


// router.use('/userDetails', UserController.userDetails);

module.exports = router;
