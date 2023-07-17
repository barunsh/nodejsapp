const BookingsModel = require('../model/bookings.model.js');

class BookingsService {
  // Create a new booking
  static async createBooking(propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate) {
    try {
      const booking = new BookingsModel({ propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate });
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


  static async updateBooking(bookingId, updatedData) {
    try {
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
}

  


module.exports = BookingsService;
