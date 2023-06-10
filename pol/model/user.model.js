const mongoose = require('mongoose');
const bcrypt = require("bcrypt");
const db = require('../config/db'); 


const { Schema } = mongoose;



const userSchema = new Schema({
    email: {
        type: String,
        lowercase: true,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    }
});

//hide password thingy here

// when save will be called
userSchema.pre('save', async function(){
    try{
        // this means we refer it to that schema 👆
        var user = this;
        const salt = await (bcrypt.genSalt(10));
        const hashpass = await bcrypt.hash(user.password,salt);

        user.password = hashpass;

    }catch(error){
        throw error;
    }
})


const UserModel = db.model('user',userSchema);

module.exports = UserModel;
