const Post = require("../../models/Post");
const populateHelper = (query,population) => {

    return query.populate(population);

};
const userSortHelper = (query,req) => {

    return query = query.sort("-likeCount -createdAt");
};
const postSortHelper = (query,req) => {
    return query = Post.aggregate([{ $sample: { size: 999999999999 } }])
};
module.exports = {
    populateHelper,
    userSortHelper,
    postSortHelper
};