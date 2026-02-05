import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = '/add-item';

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  String _title = '';
  double _price = 0;
  String _description = '';
  String _category = '';
  String _imageUrl = '';
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.addFood({
        'title': _title,
        'price': _price,
        'description': _description,
        'category': _category,
        'image_url': _imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Food item added successfully!'), backgroundColor: Colors.green),
      );
      _formKey.currentState!.reset();
      // Optional: Navigate back or stay to add more
      // Navigator.of(context).pop(); 
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Item Details',
                    style: AppTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: AppTheme.inputDecoration('Title', Icons.short_text),
                    validator: (value) => value!.isEmpty ? 'Enter title' : null,
                    onSaved: (value) => _title = value!,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: AppTheme.inputDecoration('Price', Icons.attach_money),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? 'Enter price' : null,
                    onSaved: (value) => _price = double.parse(value!),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: AppTheme.inputDecoration('Description', Icons.description),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Enter description' : null,
                    onSaved: (value) => _description = value!,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: AppTheme.inputDecoration('Category', Icons.category),
                    validator: (value) => value!.isEmpty ? 'Enter category' : null,
                    onSaved: (value) => _category = value!,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: AppTheme.inputDecoration('Image URL', Icons.image),
                    validator: (value) => value!.isEmpty ? 'Enter image URL' : null,
                    onSaved: (value) => _imageUrl = value!,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading 
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('ADD ITEM'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
