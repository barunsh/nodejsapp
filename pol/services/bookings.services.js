const BookingsModel = require('../model/bookings.model.js');

class BookingService {
  // Create a new booking
  static async createBooking(propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImageBase64, propertyImagePath) {
    try {
      const booking = new BookingsModel({
        propertyAddress,
        propertyLocality,
        propertyRent,
        propertyType,
        propertyBalconyCount,
        propertyBedroomCount,
        propertyDate,
        propertyImage:{
          data: propertyImageBase64,
          contentType: 'image/jpg',
        },
      });
      return await booking.save();
    } catch (error) {
      throw error;
    }
  }

  // Get all bookings
  static async getBooking() {
    try {
      return await BookingsModel.find();
    } catch (error) {
      throw error;
    }
  }

  // Update a booking
  static async updateBooking(bookingId, propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImage) {
    try {
      const updatedData = { propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyImage };
      return await BookingsModel.findByIdAndUpdate(bookingId, updatedData, { new: true });
    } catch (error) {
      throw error;
    }
  }

  // Delete a booking by ID
  static async deleteBooking(bookingId) {
    try {
      return await BookingsModel.findByIdAndDelete(bookingId);
    } catch (error) {
      throw error;
    }
  }


static async uploadImage(bookingId, imageBase64) {
  try {
    const booking = await BookingsModel.findById(bookingId);

    if (!booking) {
      throw new Error('Booking not found');
    }

    // Update the propertyImage field with the new image data
    booking.propertyImage = {
      data: imageBase64,
      contentType: 'image/jpg', // You can set the appropriate content type here based on the image file type
    };

    return await booking.save();
  } catch (error) {
    throw error;
  }
}
}



module.exports = BookingService;
