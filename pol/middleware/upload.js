// server.js

const express = require('express');
const multer = require('multer');
const app = express();

// Create a storage object for multer
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Set the destination folder where files will be stored
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname); // Use the original file name as the name for storing the file
  },
});

// Create the multer instance with the storage options
const upload = multer({ storage: storage });

// Use the multer middleware for the route that handles the file upload
app.post('/upload', upload.single('image'), (req, res) => {
  // Handle the uploaded file here
  res.json({ message: 'File uploaded successfully' });
});

// Start the server
app.listen(3000, () => {
  console.log('Server listening on port 3000');
});
