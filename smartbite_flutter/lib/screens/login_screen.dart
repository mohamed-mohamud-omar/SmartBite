import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      await Provider.of<AuthProvider>(context, listen: false).login(_email, _password);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.restaurant_menu, size: 80, color: AppTheme.primaryColor),
              SizedBox(height: 10),
              Text(
                'SmartBite',
                textAlign: TextAlign.center,
                style: AppTheme.displayLarge,
              ),
              SizedBox(height: 5),
              Text(
                'Delicious food at your fingertips',
                textAlign: TextAlign.center,
                style: AppTheme.bodyMedium,
              ),
              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: AppTheme.inputDecoration('Email', Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? 'Invalid email' : null,
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: AppTheme.inputDecoration('Password', Icons.lock),
                      obscureText: true,
                      validator: (value) => value!.length < 6 ? 'Password too short' : null,
                      onSaved: (value) => _password = value!,
                    ),
                    SizedBox(height: 30),
                    if (Provider.of<AuthProvider>(context).isLoading)
                      CircularProgressIndicator(color: AppTheme.primaryColor)
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text('LOGIN'),
                        ),
                      ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
