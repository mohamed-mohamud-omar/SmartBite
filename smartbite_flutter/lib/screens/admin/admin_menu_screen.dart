import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../models/food_model.dart';
import '../admin_dashboard.dart';
import 'edit_food_screen.dart';
import 'add_item_screen.dart';

class AdminMenuScreen extends StatefulWidget {
  static const routeName = '/admin-menu';

  @override
  _AdminMenuScreenState createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  final ApiService _apiService = ApiService();

  void _deleteFood(String id) async {
    try {
      await _apiService.deleteFood(id);
      setState(() {}); // Refresh list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully'), backgroundColor: Colors.green),
      );
      } catch (error) {
        String message = 'Failed to delete item';
        if (error is Exception) {
          message = error.toString().replaceFirst('Exception: ', '');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Menu')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.add),
        onPressed: () async {
           await Navigator.of(context).pushNamed(AddItemScreen.routeName);
           setState(() {}); // Refresh list when coming back
        },
      ),
      body: FutureBuilder<List<Food>>(
        future: _apiService.getFoods(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final foods = snapshot.data ?? [];
          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (ctx, i) => Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Image.network(
                  foods[i].imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_,__,___) => Icon(Icons.fastfood),
                ),
                title: Text(foods[i].title),
                subtitle: Text('\$${foods[i].price}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.of(context).pushNamed(
                            EditFoodScreen.routeName,
                            arguments: foods[i],
                          );
                          if (result == true) {
                            setState(() {}); // Refresh list
                          }
                        },
                      ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Delete Item?'),
                          content: Text('Are you sure you want to delete ${foods[i].title}?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                _deleteFood(foods[i].id);
                              },
                              child: Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
