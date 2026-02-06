/**
 * SECURITY - MEMBER 2 (Ismailbiid46@gmail.com)
 * 
 * TASK: Define authentication routes.
 * Routes: POST /register, POST /login.
 */

const express = require('express');
const router = express.Router();
const { register, login } = require('../controllers/authController');

router.post('/register', register);
router.post('/login', login);

module.exports = router;
