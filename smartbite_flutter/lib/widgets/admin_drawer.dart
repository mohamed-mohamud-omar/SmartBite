import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import '../screens/admin_dashboard.dart';
import '../screens/admin/admin_menu_screen.dart';
import '../screens/admin/admin_orders_screen.dart';
import '../screens/admin/admin_users_screen.dart';
import '../screens/admin/analytics_screen.dart';
import '../screens/login_screen.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppTheme.primaryColor),
            accountName: Text('Admin'),
            accountEmail: Text(auth.user?.email ?? 'admin@restaurant.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: TextStyle(fontSize: 40.0, color: AppTheme.primaryColor),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: AppTheme.primaryColor),
            title: Text('Dashboard'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AdminDashboard.routeName),
          ),
          ListTile(
            leading: Icon(Icons.table_restaurant, color: AppTheme.primaryColor),
            title: Text('Table Management'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/table-management'),
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu, color: AppTheme.primaryColor),
            title: Text('Manage Menu'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AdminMenuScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt_long, color: AppTheme.primaryColor),
            title: Text('Manage Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AdminOrdersScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: AppTheme.primaryColor),
            title: Text('Users'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AdminUsersScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart, color: AppTheme.primaryColor),
            title: Text('Analytics'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AnalyticsScreen.routeName);
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Dark Mode'),
            secondary: Icon(Icons.dark_mode, color: AppTheme.primaryColor),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context).pop(); // Close drawer
              auth.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
