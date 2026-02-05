import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../models/food_model.dart';

class EditFoodScreen extends StatefulWidget {
  static const routeName = '/edit-food';

  @override
  _EditFoodScreenState createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  late String _id;
  late String _title;
  late double _price;
  late String _description;
  late String _category;
  late String _imageUrl;
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final food = ModalRoute.of(context)!.settings.arguments as Food;
      _id = food.id;
      _title = food.title;
      _price = food.price;
      _description = food.description;
      _category = food.category;
      _imageUrl = food.imageUrl;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.updateFood(_id, {
        'title': _title,
        'price': _price,
        'description': _description,
        'category': _category,
        'image_url': _imageUrl,
      });
      Navigator.of(context).pop(true); // Return true to indicate update
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update item'), backgroundColor: Colors.red),
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
        title: Text('Edit Item'),
        // AppBar styles handled by global theme now
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView( // Changed from ListView to allow centered card
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600), // Max width for tablet/web
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0), // Inner card padding
                      child: Form(
                        key: _formKey,
                        child: Column( // Used Column inside ScrollView
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Food Details',
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            TextFormField(
                              initialValue: _title,
                              decoration: AppTheme.inputDecoration('Title', Icons.fastfood),
                              validator: (value) => value!.isEmpty ? 'Enter title' : null,
                              onSaved: (value) => _title = value!,
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              initialValue: _price.toString(),
                              decoration: AppTheme.inputDecoration('Price', Icons.attach_money),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              validator: (value) => value!.isEmpty ? 'Enter price' : null,
                              onSaved: (value) => _price = double.parse(value!),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              initialValue: _description,
                              decoration: AppTheme.inputDecoration('Description', Icons.description),
                              maxLines: 3,
                              validator: (value) => value!.isEmpty ? 'Enter description' : null,
                              onSaved: (value) => _description = value!,
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              initialValue: _category,
                              decoration: AppTheme.inputDecoration('Category', Icons.category),
                              validator: (value) => value!.isEmpty ? 'Enter category' : null,
                              onSaved: (value) => _category = value!,
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              initialValue: _imageUrl,
                              decoration: AppTheme.inputDecoration('Image URL', Icons.image),
                              validator: (value) => value!.isEmpty ? 'Enter image URL' : null,
                              onSaved: (value) => _imageUrl = value!,
                            ),
                            SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: _submit,
                              child: Text('UPDATE ITEM'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
