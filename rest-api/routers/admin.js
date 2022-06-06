const express = require("express");
const cors= require('cors');
const corsOptionsDelegate=require('../middlewares/cors/cors');
const {getAccessToRoute, getAdminAccess} = require("../middlewares/authorization/auth");
const { blockUser,
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
        getDiskSpace} = require("../controllers/admin");
const {checkUserExist} = require("../middlewares/database/databaseErrorHelpers");
const { checkPostExist } = require("../middlewares/database/databaseErrorHelpers");
// block user
// delete user
const router = express.Router();

router.use([getAccessToRoute, getAdminAccess]);

router.get("/block/:id",checkUserExist,blockUser);
router.delete("/user/:id", checkUserExist,deleteUser);
router.get("/os",getCpu);
router.get("/ram",getRam);
router.get("/disk",getDiskSpace);
router.get("/ostype",getOsType);
router.get("/uptime",getOsUptime);
router.get("/posts",getPostsCount);
router.get("/post/:id",checkPostExist, getSinglePost)
router.get("/users", getUsersCount);
router.get("/reports", getReportsCount);
router.get("/report",getAllReports);
router.get("/feedback", getAllFeedbacks);
router.delete("/post/:id/",checkPostExist, deletePost);
router.delete("/report/:id", deleteReport);
router.delete("/feedback/:id",deleteFeedback);

module.exports = router;