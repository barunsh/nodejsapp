const UserModel = require('../model/user.model.js');
const jwt = require('jsonwebtoken');

class UserService {
  static async registerUser(names, phone, email, password, role) {
    try {
      const createUser = new UserModel({ names, phone, email, password, role });
      return await createUser.save();
    } catch (err) {
      throw err;
    }
  }

  static async checkuser(email) {
    try {
      return await UserModel.findOne({ email });
    } catch (error) {
      throw error;
    }
  }

  static async getUser() {
    try {
      return await UserModel.find();
    } catch (error) {
      console.log('Error fetching users');
      throw error;
    }
  }

  static async updateUser(userId, names, phone, email, role) {
    try {
      console.log("look:", names); 
      console.log(userId);
      // Assuming updateData is an object with the properties to update
      const updateData = {
        names,
        phone,
        email,
        role,
      };
      console.log("Asdasd", updateData);

      // Use findByIdAndUpdate to update the user document by ID
      return await UserModel.findByIdAndUpdate(userId, updateData, { new: true });
    } catch (err) {
      throw err;
    }
  }

  static async deleteUser(userId) {
    try {
      // Find the user by their ID and remove them from the database
      return await UserModel.findByIdAndRemove(userId);
    } catch (err) {
      throw err;
    }
  }

  static async generateToken(tokenData, secretKey, jwt_expire) {
    const { names, phone, ...rest } = tokenData;
    const tokenPayload = { names, phone, ...rest };
    return jwt.sign(tokenPayload, secretKey, { expiresIn: jwt_expire });
  }
}

module.exports = UserService;
