const router = require('express').Router();
const BookingsController = require('../controllers/bookings.controller.js');

router.post('/bookings', BookingsController.createBooking);
router.get('/getbooking' , BookingsController.getBooking);
router.post('/upload', BookingsController.uploadImage);
module.exports = router;
