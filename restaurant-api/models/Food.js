/**
 * MENU CRUD - MEMBER 3 (zaadaqzomalia@gmail.com)
 * JIRA ID: KAN-5
 * 
 * TASK: Implement the Food Schema.
 * Fields: title, price, description, category, image_url.
 */

const mongoose = require('mongoose');

const foodSchema = new mongoose.Schema({
    // TODO: Member 3 - Define Food Schema
});

module.exports = mongoose.model('Food', foodSchema);
