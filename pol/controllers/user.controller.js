const { Types: { ObjectId } } = require('mongoose');
const UserService = require('../services/user.services');
const mongoose = require('mongoose');

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
    const users = await UserService.getUser();
    res.status(200).json({ status: true, users });
  } catch (error) {
    next(error);
  }
};

exports.login = async (req, res, next) => {
  try {
    const {names,email, password } = req.body;

    const user = await UserService.checkuser(email);

    if (!user) {
      return res.status(400).json({ status: false, message: "User doesn't exist!" });
    }

    const isMatch = await user.comparePassword(password);

    if (isMatch === false) {
      return res.status(400).json({ status: false, message: "Password is invalid. Please try a valid one!" });
    }

    const userDetails = {
      names: user.names,
      phone: user.phone,
      // Add other fields you want to retrieve
    };

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
    const { userId } = req.params;
    const {names,email, role, phone } = req.body;
    console.log("reqbody", req.params.userId);
    console.log("reody", req.params);
    
    
    // Convert the userId to ObjectId
    // const userIdObjectId = mongoose.Types.ObjectId(userId);

    // Call the updateUser function from UserService
    const updatedUser = await UserService.updateUser(userId, names, email, role, phone);

    // Check if the updatedUser is null or undefined (user not found)
    if (!updatedUser) {
      return res.status(404).json({ status: false, message: "User not found with the provided ID" });
    }

    res.status(200).json({ status: true, user: updatedUser });
  } catch (error) {
    next(error);
  }
};
