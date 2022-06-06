const User = require("../models/User");
const sharp = require("sharp");
const CustomError = require("../helpers/error/CustomError");
const asyncErrorWrapper = require("express-async-handler");
const {sendJwtToClient} = require("../helpers/authorization/tokenHelpers");
const {validateUserInput, comparePassword} = require("../helpers/input/inputHelpers");
const sendEmail = require("../helpers/libraries/sendEmail");
const Post = require("../models/Post");
const Feedback = require("../models/Feedback");
const fse = require("fs-extra");
const { remove, unlinkSync } = require("fs-extra");
const path = require("path");
const register = asyncErrorWrapper(async (req, res, next) => {

    const { username, name, email, password, age, gender, agree, job,location } = req.body;

    const user = await User.create({
        name,
        username,
        email,
        password,
        age,
        gender,
        agree,
        job,
        location,
    });
    sendJwtToClient(user, res);

    fse.mkdirs(path.resolve("../public/postImages/" + req.body.username.toLowerCase().trim()));

    const helloEmail = req.body.email;

    const users = await User.findOne({ email: helloEmail });

    if (!users) {
        return next(new CustomError("There is no user witg that email", 400));
    }

    await users.save();

  const emailTemp=  ` <h1>WELCOME</h1>`;

    await sendEmail({
        from: process.env.SMTP_USER,
        to: helloEmail,
        subject: "hello",
        html: emailTemp
    });

     return  res.status(200);
});



const logout = asyncErrorWrapper(async (req, res, next) => {
    const {NODE_ENV} = process.env;

    return res.status(200).cookie({
        httpOnly: true,
        expires: new Date(Date.now()),
        secure: NODE_ENV === "development" ? false : true
    }).json({
        success: true,
        message: "logout Successfully"
    });
});
const login = asyncErrorWrapper(async (req, res, next) => {
    const { username, password } = req.body;
    if (!validateUserInput( username ,password )) {
        return next(new CustomError("Please check your inputs", 400));
    }
    const user = await User.findOne({ username }).select("+password");

    if (!comparePassword(password, user.password)) {
        return next(new CustomError("Please check your credentials", 400));
    }
    sendJwtToClient(user, res);
});


const getUser = asyncErrorWrapper(async (req,res,next) => {

    res.status(200).json([req.user]);
});

const getUserPhoto = asyncErrorWrapper(async (req,res,next) => {
    const id = req.user.id;

    const post = await Post.find({"user" : id}).sort({$natural : -1});
    if(post.length>0){
      res.status(200).json(post);
    }
});

const imageUpload = asyncErrorWrapper(async (req, res, next) => {
    const  id  = req.user.id;

    const users = await User.findById(id);
    const user = await User.findByIdAndUpdate(id, {
        profile_image : req.savedProfileImage,
        image_url : `https://likefoll.xyz/postImages/${users.username}/${req.savedProfileImage}`
    }, {
        new: true,
        runValidators: true
    });
    const { filename: profile_image } = req.file 

    await sharp(req.file.path)
    .resize(300,300)
    .jpeg({quality: 80})
    .toFile(
        path.resolve(req.file.destination,`${users.username}`,profile_image)
    )
    fse.unlinkSync(req.file.path)

    return res.status(200).json({
        success: true,
        message: "Image Upload Successfull",
        data: user
    });
});


const forgotPassword = asyncErrorWrapper(async (req, res, next) => {

    const resetEmail = req.body.email;

    const user = await User.findOne({email: resetEmail});

    if (!user) {
        return next(new CustomError("There is no user with that email",400));
    }
    const resetPasswordToken = user.getResetPasswordTokenFromUser();

    await user.save();
    
    const resetPasswordUrl=`${process.env.WEB}/resetpassword/${resetPasswordToken}`
    const emailTemplate = `
      <h3>Reset Your Password</h3>
      <p> This <a href = '${resetPasswordUrl}' target = '_blank'>link</a> will expire in 1 hour</p>
    `;


    try {
        await sendEmail({
            from: process.env.SMTP_USER,
            to : resetEmail,
            subject: "Reset Your Password",
            html : emailTemplate
        });
        return res.status(200).json({
            success: true,
            message: "Token Send Your Mail"
        });
    }
    catch {
        user.resetPasswordToken = undefined;
        user.resetPasswordExpire = undefined;

        await user.save();

        return next(new CustomError("Email Could Not Be Sent", 500));
    }
});

const resetPassword = asyncErrorWrapper(async (req, res,next) => {

    const {resetPasswordToken} = req.query;

    const {password} = req.body;

    if (!resetPasswordToken) {
        return next(new CustomError("Please provide a valid token", 400));
    }
    let user = await User.findOne({
        resetPasswordToken : resetPasswordToken,
        resetPasswordExpire : {$gt : Date.now()}
    });
    if (!user) {
        return next(new CustomError("Invaid Token or Session Expired"))
    }

    user.password = password;
    user.resetPasswordToken = undefined;
    user.resetPasswordExpire = undefined;

    await user.save();

    return res.status(200).json({
        success:true,
        message: "Reset Password Process Successful"
    });
});

const editDetails = asyncErrorWrapper(async (req, res, next) => {
    const id = req.user.id;

    const user = await User.findByIdAndUpdate(id,{
        $set : {
            email : req.body.email,
            age : req.body.age,
            location : req.body.location,
            job:req.body.job
        }
    },{
        new: true,
        runValidators: true
    });
    return res.status(200).json({
        success: true,
        data: user
    });

});

const deleteUser = asyncErrorWrapper(async (req, res, next) => {
    const  id  = req.user.id;

    const user = await User.findById(id);

    fse.remove(path.resolve(`../public/postImages/${user.username}`))  

    await user.remove();

    return res.status(200).json({
        success: true,
        message: "Delete Oparation Successful"
    });
});
const feedback = asyncErrorWrapper(async (req,res,nex)=>{
    const id = req.user.id 
    const {feedback_type,message} = req.body

    const feedback = await Feedback.create({
        user: id,
        message : message,
        feedback_type : feedback_type
    });
    return res.status(200).json({
        success: true,
        data: feedback
    })
});

module.exports = {
    register,
    login,
    logout,
    getUser,
    imageUpload,
    forgotPassword,
    resetPassword,
    editDetails,
    getUserPhoto,
    deleteUser,
    feedback
};
