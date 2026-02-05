const express = require('express');
const { register, login } = require('../controllers/authController');
const { getUsers } = require('../controllers/userController');
const { protect, authorize } = require('../middleware/authMiddleware');

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.get('/users', protect, authorize('Admin'), getUsers);

module.exports = router;
