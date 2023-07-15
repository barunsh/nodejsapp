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
}

module.exports = BookingsService;
