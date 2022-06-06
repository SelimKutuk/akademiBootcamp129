const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const Schema = mongoose.Schema;
const crypto = require("crypto");
const Post = require("./Post");
const jwt = require("jsonwebtoken");

const UserSchema = new Schema({
    username : {
        type: String,
        required: [true,"Please provide a username"],
        unique: true,
        lowercase : true,
        trim : true,
        maxlength : [20, "Please make your username less than 20 characters"]
    },
    email : {
        type: String,
        unique: true,
        required: [true, "Pleace provide a email"],
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "Please provide a valid email"
        ]
    },
    password : {
        type: String,
        minlength: [6, "Please provide a password with min length 6"],
        required: [true, "Please provide a password"],
        select: false
    },
    photo_url : {
        type: String
    },
    age : {
        type: Number,
        required: true,
        min: [13, "min age 13"],
        max: [100,"max age 100"]
    },
    gender : {
        type: String,
        default: "unkown",
        enum: ["male","female","unkown"]
    },
    socialmedia_url : {
        type : String,
        required : true
    },
    image_url : {
        type: String,
        default: "https://likefoll.xyz/image/default.png"
    },
    verified_user : {
        type: Boolean,
        default: false
    },
    createdAt : {
        type: Date,
        default: Date.now
    },
    role : {
        type: String,
        default: "user",
        enum: ["user", "admin"]
    },
    location: { 
        type:String,
        default:"none",    
    },
    job :{ 
        type:String,    
        required:true
    },
    agree : {
        type: Boolean,
        default: true,
        required: true
    },
    blocked :  {
        type: Boolean,
        default: false
    },
    likeCount: { 
        type:Number,
        default:0
    },

    resetPasswordToken : {
        type: String
    },
    resetPasswordExpire : {
        type: Date
    }
});
// UserSchema Methods
UserSchema.methods.generateJwtFromUser = function(){
    const {JWT_SECRET_KEY,JWT_EXPIRE} = process.env;

    const payload = {
        id : this._id,
        username : this.username,
        profile_image : this.profile_image,
        job : this.job,
        location:this.location,
        likeCount : this.likeCount,
        image_url:this.image_url,
        role:this.role,
        blocked:this.blocked
    };

    const token = jwt.sign(payload,JWT_SECRET_KEY,{
        expiresIn : JWT_EXPIRE
    });
    return token;
};

UserSchema.methods.getResetPasswordTokenFromUser = function() {
    const randomHexString = crypto.randomBytes(15).toString("hex");
    const {RESET_PASSWORD_EXPIRE} = process.env;

    const resetPasswordToken = crypto
    .createHash("SHA256")
    .update(randomHexString)
    .digest("hex");

    this.resetPasswordToken = resetPasswordToken;
    this.resetPasswordExpire = Date.now() + parseInt(RESET_PASSWORD_EXPIRE);

    return resetPasswordToken;
};
UserSchema.pre("save", function (next) {
    if (!this.isModified("password")) {
        next();
    }
    bcrypt.genSalt(10, (err, salt) => {
        if (err) next(err);

        bcrypt.hash(this.password, salt, (err, hash) => {
            if (err) next(err);
            this.password = hash;
            next();
        });
    });
});
UserSchema.post("remove",async function(){
    await Post.deleteMany({user: this._id});
});


module.exports = mongoose.model("User", UserSchema);

