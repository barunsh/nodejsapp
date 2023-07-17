const router = require('express').Router();
const BookingsController = require('../controllers/bookings.controller.js');

router.post('/bookings', BookingsController.createBooking);
router.post('/getBooking', BookingsController.getBooking);
module.exports = router;
