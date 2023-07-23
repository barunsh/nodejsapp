// const express = require('express');
// const multer = require('multer');
// const sharp = require('sharp');
// const Image = require('./models/image.model'); // Import your image model path
// const Bookings = require('./models/bookings.model'); // Import your bookings model path
// const cloudinaryStorage = require('multer-storage-cloudinary');
// const cloudinary = require('cloudinary').v2;

// const upload = multer({
//   storage: cloudinaryStorage({
//     cloudinary: cloudinary,
//     folder: 'your-folder-name', // Set your desired folder name in Cloudinary
//     allowedFormats: ['jpg', 'jpeg', 'png'],
//   }),
// });

// const router = express.Router();

// // Handle the file upload
// router.post('/upload', upload.single('image'), async (req, res) => {
//   if (!req.file) {
//     return res.status(400).send('No image uploaded.');
//   }

//   try {
//     // Resize the image (optional)
//     const resizedImageBuffer = await sharp(req.file.buffer).resize({ width: 500, height: 500 }).toBuffer();

//     // Save the resized image to MongoDB
//     const image = new Image({
//       data: resizedImageBuffer,
//       contentType: req.file.mimetype,
//     });

//     const savedImage = await image.save();

//     // Associate the image with the booking
//     const bookingId = req.body.bookingId; // Assuming you pass the bookingId from the frontend
//     const booking = await Bookings.findById(bookingId);
//     booking.propertyImage = savedImage;
//     await booking.save();

//     res.send('Image uploaded and associated with the booking successfully!');
//   } catch (err) {
//     console.error(err);
//     res.status(500).send('Failed to save the image or associate it with the booking.');
//   }
// });

// module.exports = router;
