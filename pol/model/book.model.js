const mongoose = require('mongoose');

const { Schema } = mongoose;

const bookSchema = new mongoose.Schema({
  propertyName: { type: String },
  propertyAddress: { type: String, required: true },
  propertyRent: { type: Number, required: true },
  propertyType: { type: String, required: true },
  propertyBalconyCount: { type: Number, required: true },
  propertyBedroomCount: { type: Number, required: true },
  propertyDate: { type: Date, required: true },
  bookingRemaining: { type: Number, default: 3 },
});

module.exports = mongoose.model('Book', bookSchema);
