import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';

class AdminOrdersScreen extends StatefulWidget {
  static const routeName = '/admin-orders';

  @override
  _AdminOrdersScreenState createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final ApiService _apiService = ApiService();

  void _updateStatus(String id, String status) async {
    try {
      await _apiService.updateOrderStatus(id, status);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order updated to $status'), backgroundColor: Colors.green),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Orders')),
      body: FutureBuilder<List<dynamic>>(
        future: _apiService.getAllOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data ?? [];
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (ctx, i) {
              final order = orders[i];
              return Card(
                margin: EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text('Order #${order['_id'].substring(order['_id'].length - 6)}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['table_number'] != null
                            ? 'Table: #${order['table_number']}'
                            : 'Delivery: ${order['customer_address'] ?? 'Online Order'}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                      if (order['customer_phone'] != null)
                        Text('Phone: ${order['customer_phone']}', style: TextStyle(fontSize: 12)),
                      Text(
                        'Items: ${(order['items'] as List).map((i) => "${i['quantity']}x ${i['food_item'] != null ? i['food_item']['title'] : 'Unknown Item'}").join(', ')}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      Text('Date: ${DateFormat('MMM dd, yyyy - hh:mm a').format(DateTime.parse(order['createdAt']))}'),
                      Text(
                        '\$${order['total_amount']} - ${order['status']}',
                        style: TextStyle(
                          color: order['status'] == 'Completed' ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ORDER DETAILS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 12, color: Colors.grey)),
                              TextButton.icon(
                                icon: Icon(Icons.receipt_long, size: 18),
                                label: Text('Full Receipt'),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    '/order-receipt',
                                    arguments: order,
                                  );
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          ...(order['items'] as List<dynamic>).map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item['quantity']}x ${item['food_item'] != null ? item['food_item']['title'] : 'Unknown Item'}', style: TextStyle(fontWeight: FontWeight.w500)),
                                Text('\$${(item['price'] * item['quantity']).toStringAsFixed(2)}', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          )).toList(),
                          Divider(),
                          SizedBox(height: 10),
                          Text('Update Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () => _updateStatus(order['_id'], 'Pending'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                child: Text('Pending'),
                              ),
                              ElevatedButton(
                                onPressed: () => _updateStatus(order['_id'], 'Preparing'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                child: Text('Preparing'),
                              ),
                              ElevatedButton(
                                onPressed: () => _updateStatus(order['_id'], 'Completed'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: Text('Completed'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
