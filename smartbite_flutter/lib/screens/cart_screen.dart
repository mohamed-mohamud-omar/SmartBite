import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import 'admin/order_receipt_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int? _selectedTable;
  bool _isSubmitting = false;
  bool _isInit = true;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is int) {
        _selectedTable = args;
      }
      final auth = Provider.of<AuthProvider>(context, listen: false);
      if (auth.user != null) {
        _nameController.text = auth.user!.name;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final apiService = ApiService();
    final isAdmin = auth.user?.role == 'Admin';

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty 
            ? Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Your cart is empty", style: AppTheme.bodyMedium),
                ],
              ))
            : ListView(
              padding: EdgeInsets.all(16),
              children: [
                ...cart.items.values.map((item) {
                  final foodId = cart.items.keys.firstWhere((k) => cart.items[k] == item);
                  return Dismissible(
                    key: ValueKey(item.id),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      child: Icon(Icons.delete, color: Colors.white, size: 40),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      Provider.of<CartProvider>(context, listen: false).removeItem(foodId);
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                            child: Text('${item.quantity}x', style: TextStyle(color: AppTheme.primaryColor)),
                          ),
                          title: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                          trailing: Text('\$${item.price}', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  );
                }).toList(),

                if (!isAdmin && cart.items.isNotEmpty) ...[
                  SizedBox(height: 20),
                  Text("Delivery Information", style: AppTheme.titleLarge),
                  SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Delivery Address',
                            prefixIcon: Icon(Icons.location_on_outlined),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) => value!.isEmpty ? 'Please enter delivery address' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount", style: AppTheme.titleLarge),
                    Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    )),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (cart.itemCount == 0 || _isSubmitting)
                        ? null
                        : () async {
                            if (!isAdmin && !_formKey.currentState!.validate()) {
                              return;
                            }

                            setState(() {
                              _isSubmitting = true;
                            });
                            try {
                              final items = cart.items.values.map((item) => {
                                'food_item': item.id,
                                'quantity': item.quantity,
                                'price': item.price,
                              }).toList();
                              
                              await apiService.createOrder(
                                items, 
                                cart.totalAmount, 
                                tableNumber: _selectedTable,
                                customerName: !isAdmin ? _nameController.text : null,
                                customerAddress: !isAdmin ? _addressController.text : null,
                                customerPhone: !isAdmin ? _phoneController.text : null,
                              );
                              
                              cart.clear();
                              
                              if (isAdmin) {
                                final orders = await apiService.getAllOrders();
                                final latestOrder = orders.first;
                                
                                Navigator.of(context).pushReplacementNamed(
                                  OrderReceiptScreen.routeName,
                                  arguments: latestOrder,
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Order Placed!'),
                                    content: Text('Your order has been placed successfully. We will deliver it soon to your address.'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
                              );
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isSubmitting = false;
                                });
                              }
                            }
                          },
                    child: _isSubmitting 
                        ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(isAdmin ? 'PROCESS ORDER' : 'PLACE ORDER ONLINE'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
