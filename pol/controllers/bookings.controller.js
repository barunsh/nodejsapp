const BookingService = require('../services/bookings.services.js');
const multer = require('multer');
const fs = require('fs');
const BookingsModel = require('../model/bookings.model.js');

// Multer configuration for image uploads
const upload = multer({
  dest: 'uploads/', // Set the destination folder where files will be stored
});

// Create a new booking
exports.createBooking = async (req, res, next) => {
  try {
    const {
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyImageBase64,
      ownerName,
    } = req.body;
    console.log("CHECK MEEEE",req.body);


    const booking = await BookingService.createBooking(
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyImageBase64,
      ownerName,
      // Remove "path" from the parameters as it's not used here.
    );

    res.status(201).json({ status: true, success: "Property added  successfully", booking });
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
    const {
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyImage,
    } = req.body;

    const booking = await BookingService.updateBooking(
      bookingId,
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
      propertyImage
    );

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

// Variable to keep track of the image count
let imageCount = 0;

// Upload an image
exports.uploadImage = async (req, res, next) => {
  try {
    if (!req.file) {
      return res.status(400).json({ status: false, message: 'No image provided' });
    }

    const { path, originalname } = req.file;

    console.log('Original File Name:', originalname);
    console.log('File Path:', path);

    // Create a unique filename by appending the image count to a prefix (e.g., "image_1.jpg", "image_2.jpg", etc.)
    const imageFileName = `image_${imageCount}.jpg`;

    // Move the uploaded image to the 'uploads' folder with the unique filename
    const newPath = `uploads/${imageFileName}`;
    fs.renameSync(path, newPath);

    // Increment the image count for the next uploaded image
    imageCount++;

    // You can perform any other image-related operations here, if needed.

    res.status(200).json({ status: true, message: 'Image uploaded successfully' });
  } catch (error) {
    console.error(error);
    next(error);
  }
};