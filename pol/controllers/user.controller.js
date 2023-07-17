const UserService = require('../services/user.services');



exports.register = async (req, res, next) => {
    try {
        const { names, phone, email, password, role } = req.body;

        const successRes = await UserService.registerUser(names, phone, email, password,role);

        res.status(201).json({ status: true, success: "User successfully registered" });
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
        phone: user.phone, };
  
      const token = await UserService.generateToken(tokenData, "secretKey", '1h');
  
      res.status(200).json({ status: true, token: token, user: userDetails });
  
    } catch (error) {
      next(error);
    }
  };
  