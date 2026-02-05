const fs = require('fs');
const mongoose = require('mongoose');
const dotenv = require('dotenv');

// Load env vars
dotenv.config();

// Load models
const Food = require('./models/Food');
const User = require('./models/User');

// Connect to DB
mongoose.connect(process.env.MONGODB_URI);

// Sample Data
const foods = [
    {
        title: 'Margherita Pizza',
        price: 12.99,
        description: 'Classic tomato, mozzarella, and basil.',
        category: 'Pizza',
        image_url: 'https://images.unsplash.com/photo-1574071318508-1cdbad80ad50?auto=format&fit=crop&w=800&q=80'
    },
    {
        title: 'Classic Burger',
        price: 9.99,
        description: 'Juicy beef patty with lettuce, tomato, and cheese.',
        category: 'Burgers',
        image_url: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80'
    },
    {
        title: 'Caesar Salad',
        price: 8.50,
        description: 'Crisp romaine lettuce with Caesar dressing and croutons.',
        category: 'Salads',
        image_url: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?auto=format&fit=crop&w=800&q=80'
    }
];

const users = [
    {
        name: 'Admin User',
        email: 'admin@smartbite.com',
        password: 'password123',
        role: 'Admin'
    }
];

// Import into DB
const importData = async () => {
    try {
        await Food.create(foods);
        await User.create(users);
        console.log('Data Imported...');
        process.exit();
    } catch (err) {
        console.error(err);
    }
};

// Delete data
const deleteData = async () => {
    try {
        await Food.deleteMany();
        await User.deleteMany();
        console.log('Data Destroyed...');
        process.exit();
    } catch (err) {
        console.error(err);
    }
};

if (process.argv[2] === '-i') {
    importData();
} else if (process.argv[2] === '-d') {
    deleteData();
}
