import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';

class AnalyticsScreen extends StatefulWidget {
  static const routeName = '/admin-analytics';

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final ApiService _apiService = ApiService();
  
  bool _isLoading = true;
  double _totalSales = 0.0;
  int _totalOrders = 0;
  int _activeUsers = 0;
  String _topItem = 'N/A';
  List<dynamic> _recentOrders = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final orders = await _apiService.getAllOrders();
      final users = await _apiService.getUsers();

      // Calculate Total Sales & Total Orders
      double sales = 0;
      final Map<String, int> itemFrequency = {};

      for (var order in orders) {
        if (order == null) continue;
        
        // Safety for total sales
        final num? amount = order['total_amount'] as num?;
        if (amount != null) {
          sales += amount.toDouble();
        }

        // Safety for items
        final dynamic itemsData = order['items'];
        if (itemsData != null && itemsData is List) {
          final items = itemsData;
          for (var item in items) {
            if (item == null) continue;
            
            final dynamic foodItem = item['food_item'];
            if (foodItem != null && foodItem is Map) {
              try {
                final String? title = foodItem['title']?.toString();
                if (title != null) {
                  final int quantity = (item['quantity'] as num?)?.toInt() ?? 0;
                  itemFrequency[title] = (itemFrequency[title] ?? 0) + quantity;
                }
              } catch (e) {
                print('Error processing item title: $e');
              }
            }
          }
        }
      }

      String topItemName = 'N/A';
      int maxCount = 0;
      itemFrequency.forEach((key, value) {
        if (value > maxCount) {
          maxCount = value;
          topItemName = key;
        }
      });

      // Recent Activity (Last 5 orders)
      final recent = List.from(orders);
      // Assuming orders come sorted or we just take top ones. 
      // Ideally should be sorted by date. For now taking the list as is (usually latest first or last).
      // Let's assume API returns random order, so we reverse if needed, but here just taking last 5 if list is appended.
      // Better to just show what we have. API usually returns oldest first or latest first.
      // If it's oldest first, we should reverse.
      // Let's reverse just in case to show latest at top if it was chronological.
      if (recent.isNotEmpty) {
        // Simple reversal for timeline effect
        // recent = recent.reversed.toList(); 
      }
      final limitedRecent = recent.length > 5 ? recent.sublist(recent.length - 5).reversed.toList() : recent.reversed.toList();

      setState(() {
        _totalSales = sales;
        _totalOrders = orders.length;
        _activeUsers = users.length;
        _topItem = topItemName;
        _recentOrders = limitedRecent;
        _isLoading = false;
      });

    } catch (error) {
      // Handle error gracefully
      print('Analytics Error: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Analytics')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchData,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sales Overview', style: AppTheme.titleLarge),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Total Sales', '\$${_totalSales.toStringAsFixed(2)}', Colors.blue),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard('Total Orders', '$_totalOrders', Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Active Users', '$_activeUsers', Colors.purple),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard('Top Item', _topItem, Colors.red),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text('Recent Activity', style: AppTheme.titleLarge),
            SizedBox(height: 10),
            _recentOrders.isEmpty 
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('No recent activity'),
              )
            : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _recentOrders.length,
              itemBuilder: (ctx, i) {
                 final order = _recentOrders[i];
                 final orderId = order['_id'].toString();
                 final shortId = orderId.length > 6 ? orderId.substring(orderId.length - 6) : orderId;
                 return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Icon(Icons.receipt_long, color: AppTheme.primaryColor),
                  ),
                  title: Text('Order #$shortId'),
                  subtitle: Text(order['status'] ?? 'Unknown'),
                  trailing: Text('\$${(order['total_amount'] as num).toStringAsFixed(2)}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
