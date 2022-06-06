const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const PostSchema = new Schema({
    post_title : {
        type : String,
        required:true    
    },
    post_desc: { 
        type:String,
        required:true
    },
    post_image : {
        type : String,
        required: true
    },
    user : {
        type : mongoose.Schema.Types.ObjectId,
        required : true,
        ref: "User"
    },
    photo_url:{
        type:String
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model("Post", PostSchema);