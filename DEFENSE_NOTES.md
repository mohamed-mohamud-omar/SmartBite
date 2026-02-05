# Defense Cheatsheet: CRUD Operations

This document explains how **C.R.U.D** (Create, Read, Update, Delete) is implemented in your SmartBite project. Use this to answer questions during your defense.

## 1. Create (Adding Data)
**Definition**: Creating new records in the database.

*   **Feature**: **Register User**
    *   **Backend**: `POST /api/auth/register` (creates new `User` document).
    *   **Code**: `controllers/authController.js` -> `register` function.
*   **Feature**: **Place Order**
    *   **Backend**: `POST /api/orders` (creates new `Order` document).
    *   **Code**: `controllers/orderController.js` -> `addOrderItems` function.
*   **Feature**: **Add Food Item** (Admin)
    *   **Backend**: `POST /api/food` (creates new `Food` document).
    *   **Frontend**: `AdminDashboard` "Add Item" form.

## 2. Read (Viewing Data)
**Definition**: Fetching data from the database to display.

*   **Feature**: **View Menu**
    *   **Backend**: `GET /api/food` (fetches all `Food` items).
    *   **Frontend**: `HomeScreen` (displays Grid View).
*   **Feature**: **View Order History**
    *   **Backend**: `GET /api/orders/myorders` (fetches `Order`s where `user_id` matches logged-in user).
    *   **Frontend**: `OrderHistoryScreen`.
*   **Feature**: **View All Users** (Admin)
    *   **Backend**: `GET /api/users` (fetches all `User`s).
    *   **Frontend**: `AdminUsersScreen`.

## 3. Update (Modifying Data)
**Definition**: Changing existing records.

*   **Feature**: **Update Order Status** (Admin)
    *   **Scenario**: Changing an order from "Pending" → "Completed".
    *   **Backend**: `PUT /api/orders/:id/status`.
    *   **Code**: `controllers/orderController.js` -> `updateOrderStatus`.
    *   **Frontend**: `AdminOrdersScreen` (Buttons: Pending, Preparing, Completed).

## 4. Delete (Removing Data)
**Definition**: Removing records from the database.

*   **Feature**: **Delete Food Item** (Admin)
    *   **Scenario**: Removing a discontinued dish from the menu.
    *   **Backend**: `DELETE /api/food/:id`.
    *   **Code**: `controllers/foodController.js` -> `deleteFood`.
    *   **Frontend**: `AdminMenuScreen` (Trash icon).

---

## Technical Concept: RESTful API
Your app follows **REST** principles:
*   **resource URL**: `/api/food`
*   **HTTP Methods**:
    *   `GET` (Read)
    *   `POST` (Create)
    *   `PUT` (Update)
    *   `DELETE` (Delete)
