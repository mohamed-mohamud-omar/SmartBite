const express = require('express');
const {
    getFoods,
    getFood,
    createFood,
    updateFood,
    deleteFood
} = require('../controllers/foodController');

const { protect, authorize } = require('../middleware/authMiddleware');

const router = express.Router();

router.route('/')
    .get(getFoods)
    .post(protect, authorize('Admin'), createFood);

router.route('/:id')
    .get(getFood)
    .put(protect, authorize('Admin'), updateFood)
    .delete(protect, authorize('Admin'), deleteFood);

module.exports = router;
