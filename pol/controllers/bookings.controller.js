const BookingService = require('../services/bookings.services.js');
const multer = require('multer');

// Multer configuration for image uploads
const upload = multer({
  dest: 'uploads/', // Set the destination folder where files will be stored
});

// Create a new booking
exports.createBooking = async (req, res, next) => {
  try {
    const { propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate } = req.body;
    const booking = await BookingService.createBooking(propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate);
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

// Update a booking
exports.updateBooking = async (req, res, next) => {
  try {
    const { bookingId } = req.params;
    const { propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate } = req.body;
    const booking = await BookingService.updateBooking(bookingId, propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate);
    res.status(200).json({ status: true, success: "Booking updated successfully", booking });
  } catch (error) {
    next(error);
  }
};

// Delete a booking
exports.deleteBooking = async (req, res, next) => {
  try {
    const { bookingId } = req.params;
    await BookingService.deleteBooking(bookingId);
    res.status(200).json({ status: true, success: "Booking deleted successfully" });
  } catch (error) {
    next(error);
  }
};

// Upload an image
exports.uploadImage = async (req, res, next) => {
  try {
    const { bookingId } = req.params; // Assuming you pass the bookingId as a route parameter
    const { path, originalname } = req.file; // Assuming you use multer to handle file uploads

    // Implement your logic to store the image in MongoDB using the BookingService or any other appropriate service
    // Example: await BookingService.uploadImage(bookingId, path, originalname);

    res.status(200).json({ status: true, message: 'Image uploaded successfully' });
  } catch (error) {
    next(error);
  }
};
