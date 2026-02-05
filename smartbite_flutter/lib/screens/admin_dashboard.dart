import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import 'admin/admin_menu_screen.dart';
import 'admin/admin_orders_screen.dart';
import 'admin/admin_users_screen.dart';
import 'admin/analytics_screen.dart';
import '../widgets/admin_drawer.dart';

class AdminDashboard extends StatefulWidget {
  static const routeName = '/admin-dashboard';

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  
  Widget _buildDashboardCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview', style: AppTheme.titleLarge),
            SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildDashboardCard(
                  'Manage Menu', 
                  Icons.restaurant_menu, 
                  Colors.orange, 
                  () => Navigator.of(context).pushNamed(AdminMenuScreen.routeName)
                ),
                _buildDashboardCard(
                  'Manage Orders', 
                  Icons.receipt_long, 
                  Colors.blue, 
                  () => Navigator.of(context).pushNamed(AdminOrdersScreen.routeName)
                ),
                _buildDashboardCard(
                  'Users', 
                  Icons.people, 
                  Colors.purple, 
                  () => Navigator.of(context).pushNamed(AdminUsersScreen.routeName)
                ),
                _buildDashboardCard(
                  'Analytics', 
                  Icons.bar_chart, 
                  Colors.teal, 
                  () => Navigator.of(context).pushNamed(AnalyticsScreen.routeName)
                ),
                _buildDashboardCard(
                  'Tables', 
                  Icons.table_restaurant, 
                  AppTheme.primaryColor, 
                  () => Navigator.of(context).pushNamed('/table-management')
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
