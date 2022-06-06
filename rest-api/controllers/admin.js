const User = require("../models/User");
const CustomError = require("../helpers/error/CustomError");
const asyncErrorWrapper = require("express-async-handler");
const os = require('os');
const osx = require('os-utils');
const osu = require('node-os-utils');
const Post = require("../models/Post");
const Report = require("../models/Report");
const Feedback=require("../models/Feedback");
const {remove} = require("fs-extra");
const path=require("path");

const blockUser = asyncErrorWrapper(async (req, res, next) => {
    const {id} = req.params;

    const user = await User.findById(id);

    user.blocked = !user.blocked;

    await user.save();

    return res.status(200)
    .json({
        success: true,
        message: "Block - Unblock Successfull"
    });
});

const deleteUser = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params;

    const user = await User.findById(id);

    remove(path.resolve(`../likefoll-api/public/postImages/${user.username}`)); 
    
    await user.remove();

    return res.status(200).json({
        success: true,
        message: "Delete User Operation Successful"
    });
});

const deletePost = asyncErrorWrapper(async (req, res, next) => {
    const  {id}  = req.params;
    const post = await Post.findById(id)
    await post.remove()

    return res.status(200).json({
        success: true,
        message: "Delete Post Oparation Successful"
    });
});

const deleteReport = asyncErrorWrapper(async (req, res, next) => {
    const {id} = req.params;

    const report = await Report.findById(id);

    await report.remove();

    return res.status(200).json({
        success: true,
        message: "Delete Oparation Successful"
    });

});

const deleteFeedback = asyncErrorWrapper(async (req, res, next) => {
    const {id} = req.params;

    const feedback = await Feedback.findById(id);

    await feedback.remove();

    return res.status(200).json({
        success: true,
        message: "Delete Oparation Successful"
    });

});

const getCpu = asyncErrorWrapper(async (req, res, next) => {

    var cpu = osu.cpu

    const cpuUse = await cpu.usage()
  
    const cpuFree = await cpu.free()

    var mem = osu.mem
 
    const ramUsed = await mem.used()

    const ramFree = await mem.free()

    const osType = await os.type()

    return res.status(200).json([
        cpuUse
    ])

});

const getRam = asyncErrorWrapper(async (req, res, next) => {
    var mem = osu.mem
    const ramUsed = await mem.used()
    return res.status(200).json([
        ramUsed
    ])

});

const getOsType = asyncErrorWrapper(async (req, res, next) => {
    const osType = await os.type()
    return res.status(200).json([
        osType
    ])

});

const getDiskSpace = asyncErrorWrapper(async (req,res,next)=>{
    var drive = osu.drive

    const diskFree = await drive.free()
    const diskUsed = await drive.used()
    
    return res.status(200).json([
        diskFree
    ]);


});

const getOsUptime = asyncErrorWrapper(async (req, res, next) => {
    const osTime = await osx.processUptime()

    const time = parseInt(osTime, 10);
    const math=Math.floor(time / 3600);
    return res.status(200).json([
        math
    ])

});

const getAllReports = asyncErrorWrapper(async (req, res, next) => {
    const reports = await Report.find().sort({$natural : -1});

    return res.status(200).json(reports);

});
const getAllFeedbacks = asyncErrorWrapper(async (req, res, next) => {
    const feedbacks = await Feedback.find().sort({$natural : -1});

    return res.status(200).json(feedbacks);

});
const getSinglePost = asyncErrorWrapper(async (req, res, next) => {
    const {id} = req.params;

    const post = await Post.findById(id)

    return res.status(200).json(post);
});

const getPostsCount = asyncErrorWrapper(async (req, res, next) => {
    const posts = await Post.countDocuments()

    return res.status(200).json([posts]);

});
const getUsersCount = asyncErrorWrapper(async (req, res, next) => {
    const users = await User.countDocuments()

    return res.status(200).json([users]);

});

const getReportsCount = asyncErrorWrapper(async (req, res, next) => {
    const reports = await Report.countDocuments()
    return res.status(200).json([reports]);

});
module.exports = {
    blockUser,
    deleteUser,
    getCpu,
    getPostsCount,
    getUsersCount,
    getReportsCount,
    deletePost,
    deleteReport,
    getAllReports,
    getSinglePost,
    getAllFeedbacks,
    deleteFeedback,
    getRam,
    getOsType,
    getOsUptime,
    getDiskSpace
};
