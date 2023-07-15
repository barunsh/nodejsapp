const BookingService = require('../services/bookings.services.js');

// Create a new booking
exports.createBooking = async (req, res, next) => {
  try {
    const { propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate } = req.body;
    const booking = await BookingService.createBooking(propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate);
    res.status(201).json({ status: true, success: "Booking created successfully", booking });
  } catch (error) {
    next(error);
  }
};

// Retrieve all bookings
exports.getBooking = async (req, res, next) => {
  try {
    const booking = await BookingService.getBooking();
    res.status(200).json({ status: true, booking });
  } catch (error) {
    next(error);
  }
};
