/**
 * INTEGRATION & LOGIC - MEMBER 5 (maryamaruun847@gmail.com)
 * 
 * TASK: Implement the Order Schema.
 * Fields: items (ref Food), total_amount, status, user (ref User).
 */

const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
    // TODO: Member 5 - Define Order Schema
});

module.exports = mongoose.model('Order', orderSchema);
