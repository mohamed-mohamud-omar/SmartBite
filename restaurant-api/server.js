/**
 * BACKEND SETUP - MEMBER 1 (mohacarab162@gmail.com)
 * 
 * TASKS:
 * 1. Initialize Node.js/Express server.
 * 2. Setup MongoDB connection using Mongoose.
 * 3. Configure environment variables (dotenv).
 * 4. Mount routers for Auth, Food, and Orders.
 */

const express = require('express');
const dotenv = require('dotenv');
// const connectDB = require('./config/db'); // TODO: Member 1 - Implement this

// Load env vars
dotenv.config();

const app = express();

// Body parser
app.use(express.json());

// TODO: Member 1 - Connect to Database
// connectDB();

// TODO: Member 1 - Mount Routers (Auth, Food, Orders)

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
