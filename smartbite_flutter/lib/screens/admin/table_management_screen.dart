import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TableManagementScreen extends StatelessWidget {
  static const routeName = '/table-management';

  Widget _buildTableCard(BuildContext context, int tableNum) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/pos',
          arguments: tableNum,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.table_restaurant, size: 60, color: AppTheme.primaryColor),
            SizedBox(height: 15),
            Text(
              'Table #$tableNum',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Table to Start Order',
              style: AppTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [1, 2, 3, 4].map((n) => _buildTableCard(context, n)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
