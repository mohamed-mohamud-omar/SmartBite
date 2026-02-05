const Food = require('../models/Food');

// @desc    Get all food items
// @route   GET /api/food
// @access  Public
exports.getFoods = async (req, res, next) => {
    try {
        const foods = await Food.find();
        res.status(200).json({ success: true, count: foods.length, data: foods });
    } catch (error) {
        next(error);
    }
};

// @desc    Get single food item
// @route   GET /api/food/:id
// @access  Public
exports.getFood = async (req, res, next) => {
    try {
        const food = await Food.findById(req.params.id);
        if (!food) {
            return res.status(404).json({ success: false, message: 'Food not found' });
        }
        res.status(200).json({ success: true, data: food });
    } catch (error) {
        next(error);
    }
};

// @desc    Create new food item
// @route   POST /api/food
// @access  Private/Admin
exports.createFood = async (req, res, next) => {
    try {
        const food = await Food.create(req.body);
        res.status(201).json({ success: true, data: food });
    } catch (error) {
        next(error);
    }
};

// @desc    Update food item
// @route   PUT /api/food/:id
// @access  Private/Admin
exports.updateFood = async (req, res, next) => {
    try {
        let food = await Food.findById(req.params.id);
        if (!food) {
            return res.status(404).json({ success: false, message: 'Food not found' });
        }

        food = await Food.findByIdAndUpdate(req.params.id, req.body, {
            new: true,
            runValidators: true
        });

        res.status(200).json({ success: true, data: food });
    } catch (error) {
        next(error);
    }
};

// @desc    Delete food item
// @route   DELETE /api/food/:id
// @access  Private/Admin
exports.deleteFood = async (req, res, next) => {
    try {
        const food = await Food.findById(req.params.id);
        if (!food) {
            return res.status(404).json({ success: false, message: 'Food not found' });
        }

        await food.deleteOne();
        res.status(200).json({ success: true, data: {} });
    } catch (error) {
        next(error);
    }
};
