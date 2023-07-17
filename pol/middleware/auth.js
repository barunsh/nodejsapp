// const jwt = require('jsonwebtoken');
// const { UserModel } = require('../model/user.model.js');

// const authenticateUser = async (req, res, next) => {
//   try {
//     const token = req.headers.authorization.split(' ')[1];
//     const decoded = jwt.verify(token, 'your_secret_key');
//     const user = await UserModel.findById(decoded._id);
//     req.user = user;
//     next();
//   } catch (error) {
//     res.status(401).json({ message: 'Authentication failed' });
//   }
// };

// module.exports = { authenticateUser };