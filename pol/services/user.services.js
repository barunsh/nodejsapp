const { UserModel } = require('../model/user.model.js');
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

  static async generateToken(tokenData, secretKey, jwt_expire) {
    const { names, phone, ...rest } = tokenData;
    const tokenPayload = { names, phone, ...rest };
    return jwt.sign(tokenPayload, secretKey, { expiresIn: jwt_expire });
  }
}

module.exports = UserService;
