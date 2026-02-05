import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/food_detail_screen.dart';
import 'screens/order_history_screen.dart';
import 'screens/admin/admin_menu_screen.dart';
import 'screens/admin/admin_orders_screen.dart';
import 'screens/admin/admin_users_screen.dart';
import 'screens/admin/edit_food_screen.dart';
import 'screens/admin/add_item_screen.dart';
import 'screens/admin/analytics_screen.dart';
import 'screens/admin/order_receipt_screen.dart';
import 'screens/admin/pos_screen.dart';
import 'screens/admin/table_management_screen.dart';

void main() {
  runApp(SmartBiteApp());
}

class SmartBiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer2<AuthProvider, ThemeProvider>(
        builder: (ctx, auth, themeProvider, _) => MaterialApp(
          title: 'SmartBite',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          darkTheme: AppTheme.darkThemeData,
          themeMode: themeProvider.themeMode,
          home: auth.isAuthenticated ? HomeScreen() : LoginScreen(),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            AdminDashboard.routeName: (ctx) => AdminDashboard(),
            FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
            OrderHistoryScreen.routeName: (ctx) => OrderHistoryScreen(),
            AdminMenuScreen.routeName: (ctx) => AdminMenuScreen(),
            AdminOrdersScreen.routeName: (ctx) => AdminOrdersScreen(),
            AdminUsersScreen.routeName: (ctx) => AdminUsersScreen(),
            EditFoodScreen.routeName: (ctx) => EditFoodScreen(),
            AddItemScreen.routeName: (ctx) => AddItemScreen(),
            AnalyticsScreen.routeName: (ctx) => AnalyticsScreen(),
            OrderReceiptScreen.routeName: (ctx) => OrderReceiptScreen(),
            PosScreen.routeName: (ctx) => PosScreen(),
            TableManagementScreen.routeName: (ctx) => TableManagementScreen(),
          },
        ),
      ),
    );
  }
}
