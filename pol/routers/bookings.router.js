const router = require('express').Router();
const BookingsController = require('../controllers/bookings.controller.js');

router.post('/bookings', BookingsController.createBooking);
router.get('/getbooking' , BookingsController.getBooking);
module.exports = router;
