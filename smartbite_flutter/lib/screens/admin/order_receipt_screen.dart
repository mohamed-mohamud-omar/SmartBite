import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../theme/app_theme.dart';

class OrderReceiptScreen extends StatelessWidget {
  static const routeName = '/order-receipt';

  Future<void> _printReceipt(Map<String, dynamic> order) async {
    final pdf = pw.Document();
    
    final items = order['items'] as List<dynamic>;
    final totalAmount = order['total_amount'].toDouble();
    final orderId = order['_id'].substring(order['_id'].length - 8).toUpperCase();
    final tableNumber = order['table_number'];
    final customerName = order['customer_name'] ?? order['user_id']['name'];
    final customerAddress = order['customer_address'];
    final customerPhone = order['customer_phone'];
    final isOnline = tableNumber == null;
    final date = DateTime.parse(order['createdAt']);
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    final totalQuantity = items.fold<int>(0, (sum, item) => sum + (item['quantity'] as int));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80, // Receipt style
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text('SMARTBITE', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, letterSpacing: 2)),
                    pw.Text(isOnline ? 'ONLINE DELIVERY' : 'IN-RESTAURANT', style: pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 8),
              
              _buildPwInfoRow('Order ID:', '#$orderId'),
              _buildPwInfoRow('Customer:', customerName),
              if (!isOnline) _buildPwInfoRow('Table:', '#$tableNumber'),
              if (isOnline) ...[
                if (customerAddress != null) _buildPwInfoRow('Address:', customerAddress),
                if (customerPhone != null) _buildPwInfoRow('Phone:', customerPhone),
              ],
              _buildPwInfoRow('Total Items:', '$totalQuantity'),
              _buildPwInfoRow('Date:', formattedDate),
              
              pw.SizedBox(height: 12),
              pw.Divider(thickness: 0.5),
              pw.Text('ITEMS', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
              pw.SizedBox(height: 4),
              
              ...items.map((item) => pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(child: pw.Text('${item['quantity']}x ${item['food_item'] != null ? item['food_item']['title'] : 'Unknown Item'}', style: pw.TextStyle(fontSize: 10))),
                  pw.Text('\$${(item['price'] * item['quantity']).toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 10)),
                ],
              )).toList(),
              
              pw.Divider(thickness: 1),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('TOTAL', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                  pw.Text('\$${totalAmount.toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                ],
              ),
              
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text('Scan to Pay (EVC Plus)', style: pw.TextStyle(fontSize: 8)),
                    pw.SizedBox(height: 4),
                    pw.BarcodeWidget(
                      data: 'tel:*700*6655*${totalAmount.toInt()}#',
                      barcode: pw.Barcode.qrCode(),
                      width: 80,
                      height: 80,
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text('*700*6655*${totalAmount.toInt()}#', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 12),
                    pw.Text('Thank you!', style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Receipt_$orderId',
    );
  }

  pw.Widget _buildPwInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
          pw.Text(value, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final items = order['items'] as List<dynamic>;
    final totalAmount = order['total_amount'].toDouble();
    final orderId = order['_id'].substring(order['_id'].length - 8).toUpperCase();
    final tableNumber = order['table_number'];
    final customerName = order['customer_name'] ?? order['user_id']['name'];
    final customerAddress = order['customer_address'];
    final customerPhone = order['customer_phone'];
    final isOnline = tableNumber == null;

    final totalQuantity = items.fold<int>(0, (sum, item) => sum + (item['quantity'] as int));
    final date = DateTime.parse(order['createdAt']);
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(date);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Receipt'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _printReceipt(order),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Column(
                      children: [
                        Icon(Icons.restaurant, size: 48, color: AppTheme.primaryColor),
                        SizedBox(height: 12),
                        Text(
                          'SMARTBITE',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          isOnline ? 'ONLINE DELIVERY ORDER' : 'IN-RESTAURANT ORDER',
                          style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(height: 48, thickness: 1),
                    
                    // Info Section
                    _buildInfoRow('Order ID:', '#$orderId'),
                    _buildInfoRow('Customer:', customerName),
                    if (!isOnline) 
                      _buildInfoRow('Table:', '#$tableNumber'),
                    if (isOnline) ...[
                      if (customerAddress != null) _buildInfoRow('Address:', customerAddress),
                      if (customerPhone != null) _buildInfoRow('Phone:', customerPhone),
                    ],
                    _buildInfoRow('Total Items:', '$totalQuantity'),
                    _buildInfoRow('Date:', formattedDate),
                    
                    Divider(height: 48, thickness: 1),
                    
                    // Items Section
                    Text(
                      'ITEMS',
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    SizedBox(height: 16),
                    ...items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item['quantity']}x ${item['food_item'] != null ? item['food_item']['title'] : 'Unknown Item'}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )).toList(),
                    
                    Divider(height: 48, thickness: 2),
                    
                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL AMOUNT',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 48),
                    
                    // Footer
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Scan to Pay (EVC Plus)',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: QrImageView(
                              data: 'tel:*700*6655*${totalAmount.toInt()}#',
                              version: QrVersions.auto,
                              size: 150.0,
                              gapless: false,
                              foregroundColor: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '*700*6655*${totalAmount.toInt()}#',
                            style: TextStyle(
                              fontSize: 14, 
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Thank you for dining with us!',
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
