const BookModel = require('../model/book.model.js');

class BookService {
  // Create a new book
  static async createBook(propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate) {
    try {
      const book = new BookModel({ propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate });
      return await book.save();
    } catch (error) {
      throw error;
    }
  }

  // Get all books
  static async getBooks() {
    try {
      return await BookModel.find();
    } catch (error) {
      throw error;
    }
  }

  // Update a book
  static async updateBook(bookId, propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate) {
    try {
      const updatedData = { propertyName, propertyAddress, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate };
      return await BookModel.findByIdAndUpdate(bookId, updatedData, { new: true });
    } catch (error) {
      throw error;
    }
  }

  // Delete a book by ID
  static async deleteBook(bookId) {
    try {
      return await BookModel.findByIdAndDelete(bookId);
    } catch (error) {
      throw error;
    }
  }
}

module.exports = BookService;
