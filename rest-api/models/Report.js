const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ReportSchema = new Schema({
    comment : {
        type : String,
    },
    post_image :{
        type: mongoose.Schema.Types.ObjectId,
        required : true,
        ref : "Post"
    },
    report_type : {
        type: String,
        default : "choose",
        enum: ["choose",
                "Spam",
                "Pornographic content",
                "Abominable content",
                "Terorism or Violance",
                "Provacative political content",
                "Hate speech",
                "Racism",
                "Other"],
        required:true
    }
});

module.exports = mongoose.model("Report",ReportSchema);
