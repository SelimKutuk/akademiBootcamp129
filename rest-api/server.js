const express = require("express");
const dotenv = require("dotenv");
const connectDatabase = require("./helpers/database/connectDatabase");
const customErrorHandler = require("./middlewares/errors/customErrorHandler");
const path = require("path");
const cors = require("cors");
const corsOptionsDelegate=require("./middlewares/cors/cors");
const routers = require("./routers");

//Enivorment Varibles
dotenv.config({
    path: "./config/env/config.env"
});

// MongoDb Connection

connectDatabase();

const app = express();

// Express - Body Middleware
app.use(express.json());
//app.use(cors(corsOptionsDelegate));



const PORT = process.env.PORT;

// Routers Middleware

app.use("/api", routers);

// Error Handler

app.use(customErrorHandler);

// Static Files

app.use(express.static(path.join(__dirname, "public")));

console.log("APP BACKEND SERVER APİ");
console.log("----------------------------");
app.listen(PORT,() => {
    console.log(`App started on ${PORT}: ${process.env.NODE_ENV}`);
}); 

