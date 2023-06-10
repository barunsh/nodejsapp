const UserService = require('../services/user.services');

exports.register = async(req,res,next)=> {
    try{
        const {names,phone,email,password} = req.body;

        const successRes = await UserService.registerUser(names,phone,email,password);

        res.json({status:true, success: "User successfully registered"});
    } catch(error){
        throw error
    }

}

exports.login = async(req,res,next)=> {
    try{
        const {email,password} = req.body;

        const successRes = await UserService.registerUser(email,password);

        res.json({status:true, success: "User successfully registered"});
    } catch(error){
        throw error
    }

}