const { Types: { ObjectId } } = require('mongoose'); // Import the ObjectID class from mongoose
const UserService = require('../services/user.services');
// const {ObjectID} = require('mongodb');


exports.register = async (req, res, next) => {
  try {
    const { names, phone, email, password, role } = req.body;

    const successRes = await UserService.registerUser(names, phone, email, password, role);

    res.status(201).json({ status: true, success: "User successfully registered" });
  } catch (error) {
    next(error);
  }
};

exports.getUser = async (req, res, next) => {
  try {
    const users = await UserService.getUser(); // Call getUser from UserService
    res.status(200).json({ status: true, users });
  } catch (error) {
    next(error);
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    // check email from the database
    const user = await UserService.checkuser(email);

    if (!user) {
      return res.status(400).json({ status: false, message: "User doesn't exist!" });
    }

    const isMatch = await user.comparePassword(password);

    if (isMatch === false) {
      return res.status(400).json({ status: false, message: "Password is invalid. Please try a valid one!" });
    }

    // Retrieve all user details
    const userDetails = {
      names: user.names,
      phone: user.phone,
      // Add other fields you want to retrieve
    };
    console.log("User details fetched:", userDetails);
    let tokenData = {
      _id: user._id,
      email: user.email,
      role: user.role,
      names: user.names,
      phone: user.phone,
    };

    const token = await UserService.generateToken(tokenData, "secretKey", '1h');

    res.status(200).json({ status: true, token: token, user: userDetails });

  } catch (error) {
    next(error);
  }
};

exports.updateUser = async (req, res, next) => {
  try {
    const { userId } = req.params; // Get the user ID from the request parameters
    const { names, email, role } = req.body; // Get the updated user data from the request body
    console.log("params", req.params);
    console.log("reqbody",req.body);
    console.log("names",names);
    
    // Call the updateUser function from UserService
    const updatedUser = await UserService.updateUser(userId, names, email, role);

    // Check if the updatedUser is null or undefined (user not found)
    if (!updatedUser) {
      return res.status(404).json({ status: false, message: "User not found with the provided ID" });
    }

    res.status(200).json({ status: true, user: updatedUser });
  } catch (error) {
    next(error);
  }
};
