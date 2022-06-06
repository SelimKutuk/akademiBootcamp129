const express = require("express");
const cors = require('cors');
const timeout = require('connect-timeout');
const corsOptionsDelegate=require('../middlewares/cors/cors');
const {checkUserExist} = require("../middlewares/database/databaseErrorHelpers");
const ImageUpload = require("../middlewares/libraries/imageUpload");
const {uploadImage, getAllPost, deletePost,reportPost} = require("../controllers/post");
const {getAccessToRoute, getPostOwnerAccess} = require("../middlewares/authorization/auth");
const { checkPostExist } = require("../middlewares/database/databaseErrorHelpers");
const postQueryMiddleware = require("../middlewares/query/postQueryMiddleware");
const Post = require("../models/Post");

const router = express.Router();

router.get("/",cors(corsOptionsDelegate),postQueryMiddleware(Post,{ 
    population : {
        path : "post",
        select : "post_url post_image"
    }
}),getAllPost)
router.post("/upload",timeout('300s'),[getAccessToRoute,ImageUpload.single("post_image")],uploadImage); 
router.delete("/:id/delete",[getAccessToRoute,checkPostExist,getPostOwnerAccess],deletePost)
router.post("/:id/report",checkPostExist,reportPost);

module.exports = router;
