const express = require("express");
const cors = require('cors');
const corsOptionsDelegate=require('../middlewares/cors/cors');
const {getSingleUser,
       getAllUsers,
       likeProfile,
       undoLikeProfile,
       getSingleUserPhoto} = require("../controllers/user");
const { getAccessToRoute, getUserOwnerAccess } = require("../middlewares/authorization/auth");
const {checkUserExist} = require("../middlewares/database/databaseErrorHelpers");
const userQueryMiddleware = require("../middlewares/query/userQueryMiddleware");
const User = require("../models/User");

const router = express.Router();

router.get("/",[getAccessToRoute],userQueryMiddleware(User),getAllUsers);
router.get("/:id",checkUserExist,getSingleUser); 
router.get("/photo/:id",checkUserExist,getSingleUserPhoto); 
router.get("/:id/like",[getAccessToRoute, checkUserExist], likeProfile);
router.get("/:id/undo_like",[getAccessToRoute, checkUserExist], undoLikeProfile);

 
module.exports = router;
