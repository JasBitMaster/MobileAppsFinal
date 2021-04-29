import 'package:flutter/material.dart';

import '../services/my_controller.dart';
import '../utils/string_validator.dart';
import 'user_list_page.dart';

class SignInAccountPage extends StatefulWidget {
  @override
  _SignInAccountPageState createState() => _SignInAccountPageState();
}

class _SignInAccountPageState extends State<SignInAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
              ),
            ),
            TextFormField(
              controller: _pwController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: validatePassword,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  final result = await MyController.signIn(
                    email: _emailController.text,
                    password: _pwController.text,
                  );
                  if (result == null) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UserListPage()));
                  } else {
                    setState(() {
                      _errorMessage = result;
                    });
                  }
                }
              },
              child: Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }
}
