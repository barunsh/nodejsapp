const mongoose = require('mongoose');
const { Schema } = mongoose;

// ... (Counter schema and Counter model code remains unchanged)

const bookingsSchema = new mongoose.Schema({
  id: { type: Number, unique: true },
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
  ownerId: { type: Schema.Types.ObjectId, ref: 'User' },
});

// Middleware to auto-increment the ID before saving (remains unchanged)

module.exports = mongoose.model('Bookings', bookingsSchema);
