const BookService = require('../services/book.services.js');
const Property = require ('../model/property.model.js');
// Create a new booking
const createBook = async (req, res, next) => {
  try {
    const {
      userId,
      userName,
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyImage,
      propertyDate,
    } = req.body;

    const formattedPropertyDate = new Date(propertyDate);
      

    const booking = await BookService.createBook(
      userId,
      userName,
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyImage,
      formattedPropertyDate,
      // propertyImage,
    );
    
    // const property = await Property.findById(booking.propertyId);

    // if (!property) {
    //   return res.status(404).json({ status: false, message: 'Property not found' });
    // }

    // // Check if the property is available for booking
    // if (property.bookingRemaining <= 0) {
    //   return res.status(400).json({ status: false, message: 'Booking full' });
    // }

    // // Decrease the bookingRemaining count by 1
    // property.bookingRemaining -= 1;

    // // Save the updated property to the database
    // await property.save();


    res.status(201).json({
      status: true,
      message: 'Booking created successfully',
      data: booking,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      status: false,
      message: 'Failed to create booking',
      error: error.message,
    });
  }
};

// Update a booking
const updateBooking = async (req, res, next) => {
  try {
    const {
      bookingId,
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate,
    } = req.body;

    const updatedBooking = await BookService.updateBook(
      bookingId,
      propertyAddress,
      propertyLocality,
      propertyRent,
      propertyType,
      propertyBalconyCount,
      propertyBedroomCount,
      propertyDate
    );

    res.status(200).json({
      status: true,
      message: 'Booking updated successfully',
      data: updatedBooking,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      status: false,
      message: 'Failed to update booking',
      error: error.message,
    });
  }
};

// Delete a booking
const deleteBooking = async (req, res, next) => {
  try {
    const { bookingId } = req.params;

    const deletedBooking = await BookService.deleteBook(bookingId);

    res.status(200).json({
      status: true,
      message: 'Booking deleted successfully',
      data: deletedBooking,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      status: false,
      message: 'Failed to delete booking',
      error: error.message,
    });
  }
};

module.exports = {
  createBook,
  updateBooking,
  deleteBooking,
};
