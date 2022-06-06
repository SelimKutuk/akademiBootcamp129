const express = require("express");
const post = require("./post");
const auth = require("./auth");
const user = require("./user");
const admin = require("./admin");

// /api
const router = express.Router();

router.use("/post",post);
router.use("/auth",auth);
router.use("/users",user);
router.use("/admin", admin);


module.exports = router;