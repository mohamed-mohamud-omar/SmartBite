import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';

class AdminUsersScreen extends StatelessWidget {
  static const routeName = '/admin-users';
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registered Users')),
      body: FutureBuilder<List<dynamic>>(
        future: _apiService.getUsers(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data ?? [];
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, i) => ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                child: Text(users[i]['name'][0].toUpperCase()),
              ),
              title: Text(users[i]['name']),
              subtitle: Text(users[i]['email']),
              trailing: Chip(
                label: Text(users[i]['role']),
                backgroundColor: users[i]['role'] == 'Admin' ? Colors.red[100] : Colors.blue[100],
              ),
            ),
          );
        },
      ),
    );
  }
}
