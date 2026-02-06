/**
 * BACKEND SETUP - MEMBER 1 (mohacarab162@gmail.com)
 * 
 * STATUS: COMPLETED BY ANTIGRAVITY
 */

const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const connectDB = require('./config/db');

// Load env vars
dotenv.config();

const app = express();

// Body parser
app.use(express.json());

// Enable CORS (Standard for collaborative projects)
app.use(cors());

// Connect to Database
connectDB();

// TODO: Member 1 - Mount Routers (Auth, Food, Orders)
// These will be available once Members 2, 3, and 5 implement their routes.
// app.use('/api/auth', require('./routes/authRoutes')); 

app.get('/', (req, res) => {
    res.send('SmartBite API is running...');
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`);
});
