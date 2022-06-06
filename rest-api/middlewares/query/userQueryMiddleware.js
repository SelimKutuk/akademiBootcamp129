const  asyncErrorWrapper = require("express-async-handler");

const {userSortHelper, populateHelper} = require("./queryMiddlewareHelpers");

const userQueryMiddleware = function(model, options) {
    return asyncErrorWrapper(async function(req, res, next) {

        let query = model.find();
        
        query = userSortHelper(query, req);

        const queryResults = await query;
        
        res.queryResults = queryResults

        next();
    });
};

module.exports = userQueryMiddleware;