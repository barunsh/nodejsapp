const mongoose = require('mongoose');

const { Schema } = mongoose;

const bookingsSchema = new mongoose.Schema({
  propertyName: {
    type: String,
    // required: true,
  },
  propertyAddress: {
    type: String,
    // required: true,
  },
  propertyRent: {
    type: Number,
    // required: true,
  },
  propertyType: {
    type: String,
    // required: true,
  },
  propertyBalconyCount: {
    type: Number,
    // required: true,
  },
  propertyBedroomCount: {
    type: Number,
    // required: true,
  },
  propertyDate: {
    type: Date,
    // required: true,
  },
});

module.exports = mongoose.model('Bookings', bookingsSchema);
