const whitelist = [
"https://www.likefoll.com"
,"https://likefoll.com"
,"http://likefoll.com"
,"http://www.likefoll.com"
,"http://104.198.139.24"];

const cors = require('cors');

const corsOptionsDelegate = function (req, callback) {
  var corsOptions;
  if (whitelist.indexOf(req.header('Origin')) !== -1) {
    corsOptions = { origin: true } // reflect (enable) the requested origin in the CORS response
  } else {
    corsOptions = { origin: false } // disable CORS for this request
  }
  callback(null, corsOptions) // callback expects two parameters: error and options
}

module.exports = corsOptionsDelegate;
