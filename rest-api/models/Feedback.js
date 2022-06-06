const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const FeedbackSchema = new Schema({

    user:{
        type:mongoose.Schema.Types.ObjectId,
        required : true,
        ref : "User"
    },
    feedback_type:{
        type:String,
        default:"Choose",
        enum:["Stroll",
              "User Profiles",
              "Account Section",
              "İnformation",
              "Photo upload section",
              "Menus",
              "User Profiles",
              "Login and Register",
              "other"]
    },
    message:{
        type:String,
        required:true
    }

});
module.exports = mongoose.model("Feedback",FeedbackSchema);
