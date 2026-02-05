const express = require('express');
const {
    createOrder,
    getMyOrders,
    getOrders,
    updateOrderStatus
} = require('../controllers/orderController');

const { protect, authorize } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(protect);

router.route('/')
    .get(authorize('Admin'), getOrders)
    .post(createOrder);

router.get('/myorders', getMyOrders);
router.put('/:id/status', authorize('Admin'), updateOrderStatus);

module.exports = router;
