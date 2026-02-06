/**
 * MENU CRUD - MEMBER 3 (zaadaqzomalia@gmail.com)
 * 
 * TASK: Define food (menu) routes.
 * Routes: GET /, GET /:id, POST /, PUT /:id, DELETE /:id.
 * Tip: Protect write routes with auth and admin middleware.
 */

const express = require('express');
const router = express.Router();
const { getFoods } = require('../controllers/foodController');

router.get('/', getFoods);

// TODO: Member 3 - Add other CRUD routes

module.exports = router;
