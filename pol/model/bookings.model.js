const mongoose = require('mongoose');

const { Schema } = mongoose;

// Counter schema to track the next available ID
const counterSchema = new mongoose.Schema({
  _id: { type: String, required: true },
  seq: { type: Number, default: 1 },
});

// Create a Counter model
const Counter = mongoose.model('Counter', counterSchema);

const bookingsSchema = new mongoose.Schema({
  id: { type: Number, unique: true },
  propertyAddress: { type: String,required: true},
  propertyLocality: { type: String, required: true },
  propertyRent: { type: Number, required: true },
  propertyType: { type: String, required: true },
  propertyBalconyCount: { type: Number, required: true },
  propertyBedroomCount: { type: Number, required: true },
  propertyDate: { type: Date, required: true },
  propertyImage: {
    data: Buffer,
    contentType: String
  },
  bookingRemaining: { type: Number, default: 3 },
  ownerId: { type: Schema.Types.ObjectId, ref: 'User' },
});

// Middleware to auto-increment the ID before saving
bookingsSchema.pre('save', async function (next) {
  if (this.isNew) {
    const doc = this;
    try {
      const counter = await Counter.findByIdAndUpdate(
        { _id: 'bookingsId' },
        { $inc: { seq: 1 } },
        { new: true, upsert: true }
      );
      doc.id = counter.seq;
      next();
    } catch (error) {
      next(error);
    }
  } else {
    next();
  }
});

module.exports = mongoose.model('Bookings', bookingsSchema);
