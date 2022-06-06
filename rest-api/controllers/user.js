const CustomError = require("../helpers/error/CustomError");
const asyncErrorWrapper = require("express-async-handler");
const User = require("../models/User");
const Post = require("../models/Post")

const getSingleUser = asyncErrorWrapper(async (req, res, next) => {
    const {id} = req.params;

    const user = await User.findById(id);

    if (!user) {
        return next(new CustomError("There is no such user with that id", 400));
    }

    return res.status(200).json([user]);
});

const getSingleUserPhoto = asyncErrorWrapper(async (req,res,next) => {
    const {id} = req.params;
    
    const user = await User.findById(id);
    const post = await Post.find({"user" : id}).sort({$natural : -1});
    if (!user) {
        return next(new CustomError("There is no such user with that id", 400));
    }
    if(post.length>0){
        return res.status(200).json(post);
    }

});

const getAllUsers = asyncErrorWrapper(async (req, res, next) => {
    return res.status(200).json(res.queryResults);
});

const likeProfile = asyncErrorWrapper(async (req, res, next) => {
    const {id} = req.params;

    const user = await User.findById(id);

    if(user.likes.includes(req.user.id)) {
        return next(new CustomError("you already liked this user",400));
    }
    user.likes.push(req.user.id);
    user.likeCount = user.likes.length;

    await user.save();

    return res.status(200)
    .json(true);
});

const undoLikeProfile = asyncErrorWrapper(async (req, res, next) => {
    const {id} = req.params;

    const user = await User.findById(id);

    if(!user.likes.includes(req.user.id)) {
        return next(new CustomError("you can not undo like operation for this profile",400));
    }
    const index = user.likes.indexOf(req.user.id);

    user.likes.splice(index, 1);
    user.likeCount = user.likes.length;

    await user.save();

    return res.status(200)
    .json({
        success: true,
        data : user
    });
});


module.exports = {
    getSingleUser,
    getAllUsers,
    likeProfile,
    undoLikeProfile,
    getSingleUserPhoto
};
