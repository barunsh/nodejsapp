const UserModel = require('../model/user.model');

class UserService{
    static async registerUser(names,phone,email,password){
        try{
            const createUser = new UserModel({names,phone,email,password});
            return await createUser.save();
        }catch(err){
            throw err;
        }
    }
}

module.exports = UserService;