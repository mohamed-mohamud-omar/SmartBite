# SmartBite - Restaurant Management System

SmartBite is a comprehensive full-stack solution for modern restaurant management, featuring a robust Node.js backend and a premium Flutter mobile application.

## 🚀 Features

### Mobile App (Customer)
*   **User Authentication**: Secure Sign Up & Login.
*   **Menu Browsing**: Grid view of food categories (Burgers, Pizza, etc.).
*   **Smart Search**: Real-time food search functionality.
*   **Cart System**: Add items, adjust quantities, and swipe-to-remove.
*   **Order History**: Track status of current and past orders.

### Admin Panel (Manager)
*   **Menu Management**: Add, Edit, and Delete food items.
*   **Order Dashboard**: View all incoming orders and update their status (Pending → Preparing → Completed).
*   **User Management**: View all registered customers.

## 🛠 Tech Stack

*   **Backend**: Node.js, Express.js
*   **Database**: MongoDB (Mongoose ODM)
*   **Frontend**: Flutter (Dart)
*   **State Management**: Provider
*   **Authentication**: JWT (JSON Web Tokens)

## 📦 Installation & Setup

### Prerequisites
*   Node.js & npm installed.
*   MongoDB installed and running.
*   Flutter SDK installed.

### 1. Backend Setup
Navigate to the `restaurant-api` folder:
```bash
cd restaurant-api
npm install
```

**Environment Variables**:
Create a `.env` file in `restaurant-api/` based on `.env.example`:
```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/smartbite
JWT_SECRET=your_secret_key
NODE_ENV=development
```

**Seed Database** (Optional):
Populate with sample data and admin account:
```bash
npm run data:import
```
*Admin connection: `admin@smartbite.com` / `password123`*

**Start Server**:
```bash
npm start
```

### 2. Frontend Setup
Navigate to the `smartbite_flutter` folder:
```bash
cd smartbite_flutter
flutter pub get
```

**Run App**:
```bash
flutter run
```

## 🛡️ Project Structure

```
SmartBite/
├── restaurant-api/       # Backend Code
│   ├── config/           # DB Setup
│   ├── controllers/      # Logic (Auth, Food, Orders)
│   ├── middleware/       # Auth & Error Handling
│   ├── models/           # DB Schemas
│   └── routes/           # API Endpoints
│
└── smartbite_flutter/    # Mobile Frontend
    ├── lib/
    │   ├── models/       # Data Models
    │   ├── providers/    # State Management
    │   ├── screens/      # UI Views (User & Admin)
    │   ├── services/     # API Integration
    │   ├── theme/        # App Styling
    │   └── widgets/      # Reusable UI
```

## 👥 Contributors
Developed for the Restaurant Management System Assignment.
