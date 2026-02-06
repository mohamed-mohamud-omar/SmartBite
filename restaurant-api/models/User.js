/**
 * SECURITY - MEMBER 2 (Ismailbiid46@gmail.com)
 * JIRA ID: KAN-4
 * 
 * TASK: Implement the User Schema.
 * Fields: name, email, password, role.
 * Tip: Use bcrypt for password hashing in a pre-save hook.
 */

const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    // TODO: Member 2 - Define User Schema
});

module.exports = mongoose.model('User', userSchema);
