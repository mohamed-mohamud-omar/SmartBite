import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import '../screens/home_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/login_screen.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppTheme.primaryColor),
            accountName: Text(auth.user?.name ?? 'Guest'),
            accountEmail: Text(auth.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                (auth.user?.name ?? 'G')[0].toUpperCase(),
                style: TextStyle(fontSize: 40.0, color: AppTheme.primaryColor),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu, color: AppTheme.primaryColor),
            title: Text('Menu'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.history, color: AppTheme.primaryColor),
            title: Text('Order History'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrderHistoryScreen.routeName);
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
          Spacer(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context).pop();
              auth.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
