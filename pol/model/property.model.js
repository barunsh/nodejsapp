const mongoose = require('mongoose');
const { Schema } = mongoose;


const propertySchema = new mongoose.Schema({
  propertyAddress: { type: String, required: true },
  propertyLocality: { type: String, required: true },
  propertyRent: { type: Number, required: true },
  propertyType: { type: String, required: true },
  propertyBalconyCount: { type: Number, required: true },
  propertyBedroomCount: { type: Number, required: true },
  propertyDate: { type: Date, required: true }, // Changed to a single field for date and time
  propertyImage: {
    data: Buffer,
    contentType: String
  },
  bookingRemaining: { type: Number, default: 3 },
  ownerName: {type: String},
});

// Middleware to auto-increment the ID before saving (remains unchanged)

module.exports = mongoose.model('Property', propertySchema);
