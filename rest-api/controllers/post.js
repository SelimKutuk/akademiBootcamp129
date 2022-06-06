
const Post = require("../models/Post");
const sharp = require("sharp");
const CustomError = require("../helpers/error/CustomError");
const asyncErrorWrapper = require("express-async-handler");
const Report = require("../models/Report");
const path = require("path");
const {remove,unlinkSync} = require("fs-extra");
const {POST_PATH}=process.env;
const User = require("../models/User");

const getAllPost = asyncErrorWrapper(async (req, res, next) => {
    return res.status(200).json(res.queryResults);
});

const uploadImage = asyncErrorWrapper(async (req, res, next) => {
    const {post_title,post_desc,} = req.body;
    const  id  = req.user.id;

    const user = await User.findById(id);
    const post = await Post.create({
        post_desc,
        post_title,
        post_image : req.savedImage,
        photo_url:`http://34.89.242.41/api/postImages/${user.username}/${req.savedImage}`,
        user: id
    });
    const { filename: post_image } = req.file 

    await sharp(req.file.path)
    .resize(1080,1350)
    .jpeg({quality: 70})
    .toFile(
        path.resolve(req.file.destination,`${user.username}`,post_image)
    )
    unlinkSync(req.file.path)
    
    return res.status(200).json({
        success: true,
        data: post
    })
});

const deletePost = asyncErrorWrapper(async (req, res, next) => {
    const  id  = req.params.id;
    const ids = req.user.id
    const user = await User.findById(ids);
    const posts = await Post.findByIdAndDelete(id);
    remove(path.resolve(`../likefoll-api/public/postImages/${user.username}/${posts.post_image}`));

    return res.status(200)
        .json({
            success: true,
            message: "Post delete operation successful"
        });
});

const reportPost = asyncErrorWrapper(async (req, res, next) => {
    const post_id = req.params.id
    const {comment, report_type} = req.body

    const report = await Report.create({
        post_image: post_id,
        comment : comment,
        report_type : report_type
    });

    return res.status(200).json({
        success: true,
        data: report
    })
});


module.exports = {
    uploadImage,
    getAllPost,
    deletePost,
    reportPost
};
