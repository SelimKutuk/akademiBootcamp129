const CustomError = require("../../helpers/error/CustomError");
const asyncErrorWrapper = require("express-async-handler");
const User = require("../../models/User");

const jwt = require("jsonwebtoken");
const { isTokenIncluded, getAccessTokenFromHeader } = require("../../helpers/authorization/tokenHelpers");
const Post = require("../../models/Post");

const getAccessToRoute = (req, res, next) => {
    const {JWT_SECRET_KEY} = process.env;

    if (!isTokenIncluded(req)) {
        // 401, 403
        // 401 Unauthorzized
        // 403 Forbiddens
        return next(
            new CustomError("You are not authorized to access this route", 401)
        );
    }
    const accessToken = getAccessTokenFromHeader(req);

    jwt.verify(accessToken,JWT_SECRET_KEY,(err,decoded) => {
        if (err) {
            return next(
                new CustomError("You are not authorized to access this route", 401)
            );
        }
        req.user = {
            id : decoded.id,
            username : decoded.username,
            profile_image : decoded.profile_image,
            socialmedia_url : decoded.socialmedia_url,
            image_url:decoded.image_url,
            likeCount : decoded.likeCount,
            role:decoded.role,
            blocked:decoded.blocked
        };
        next();
    })
};

const getAdminAccess = asyncErrorWrapper(async (req, res, next) => {

    const {id} = req.user;

    const user = await User.findById(id);

    if (user.role !== "admin") {
        return next(new CustomError("Only admins can access can this route", 403));
    }
    next();
});

const getPostOwnerAccess = asyncErrorWrapper(async (req, res, next) => {
    const userId = req.user.id;
    const postId = req.params.id;
    
    const post = await Post.findById(postId);

    if (post.user != userId) {
        return next(new CustomError("Only owner can handle this operation", 403));
    }
    next();
});
const getUserOwnerAccess = asyncErrorWrapper(async (req, res, next) => {
    const userId = req.user.id;
    
    await User.findById(userId);

    if (userId != userId) {
        return next(new CustomError("Only owner can handle this operation", 403));
    }
    next();
});


module.exports = {
    getAccessToRoute,
    getAdminAccess,
    getPostOwnerAccess,
    getUserOwnerAccess
};