const CustomError = require("../../helpers/error/CustomError");
const customErrorHandler = (err, req, res, next) => {
    let customError = err;
    console.log(err);
    if (err.name == "SyntaxError") {
        customError = new CustomError("Unexpected Syntax", 400);
    }
    if (err.name == "ValidationError") {
        customError = new CustomError(err.message, 400);
    }
    if (err.name == "CastError") {
        customError = new CustomError("Please provide a vaild id", 400);
    }
    if (err.code == 11000) {
        // Duplicate Key
        if(err.keyPattern['username']==1){
            customError=new CustomError("Username found",401)
        }
        if(err.keyPattern['email']==1){
            customError=new CustomError("Email found",400)
        }
    }
 
    
    res.status(customError.status || 500).json({
        success: false,
        message: customError.message 
        });
};

module.exports = customErrorHandler;