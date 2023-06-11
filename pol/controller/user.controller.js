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

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        console.log("------", password);

        // check email from database
        const user = await UserService.checkuser(email);
        console.log("------", password);

        if (!user) {
            return res.status(400).json({ status: false, message: "User doesn't exist!" });
        }

        const isMatch = await user.comparePassword(password);

        if (isMatch === false) {
            return res.status(400).json({ status: false, message: "Password is invalid. Please try a valid one!" });
        }

        let tokenData = {_id:user._id, email:user.email};

        const token = await UserService.generateToken(tokenData, "secretKey", '1h');

        res.status(200).json({status: true, token: token})
        // ... (rest of your code)
        
    } catch (error) {
        throw error 
        next(error);
    }
};