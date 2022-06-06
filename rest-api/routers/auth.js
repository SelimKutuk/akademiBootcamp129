const express = require("express");
const {register ,
        login ,
        getUser,
        logout,
        imageUpload,
        forgotPassword,
        resetPassword,
        editDetails, 
        getUserPhoto,
        deleteUser,
        feedback} = require("../controllers/auth");
const {getAccessToRoute} = require("../middlewares/authorization/auth");
const cors= require('cors');
const corsOptionsDelegate=require('../middlewares/cors/cors');
const {checkUserExist} = require("../middlewares/database/databaseErrorHelpers");
const profileImageUpload = require("../middlewares/libraries/profileImageUpload");
const router = express.Router();

router.post("/register",register); 
router.post("/login",login); 
router.get("/profile",getAccessToRoute , getUser);  
router.get("/userphoto",getAccessToRoute,getUserPhoto); 
router.get("/logout",getAccessToRoute , logout);
router.post("/forgotpassword",forgotPassword);
router.put("/resetpassword", resetPassword);
router.post("/upload",[getAccessToRoute,profileImageUpload.single("profile_image")],imageUpload); 
router.post("/:id/feedback",getAccessToRoute,checkUserExist,feedback);
router.put("/edit",getAccessToRoute,editDetails);
router.delete("/:id/delete",[getAccessToRoute,checkUserExist], deleteUser);

module.exports = router;