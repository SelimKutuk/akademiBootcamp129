const asyncErrorWrapper = require("express-async-handler");
const { populateHelper, postSortHelper } = require("./queryMiddlewareHelpers");

const postQueryMiddleware = function(model,options){

    return asyncErrorWrapper(async function (req,res,next){
        let query = model.find();

        if (options && options.population) {
            query = populateHelper(query, options.population);
        }

        query = postSortHelper(query, req);

        const queryResults = await query;
        
        res.queryResults = queryResults

        next();
    });

}

module.exports = postQueryMiddleware;