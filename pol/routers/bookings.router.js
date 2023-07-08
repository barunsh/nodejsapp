const router = require('express').Router();
const BookingsController = require('../controllers/bookings.controller.js');

router.post('/bookings', BookingsController.createBooking);

module.exports = router;
