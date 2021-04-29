import 'package:flutter/material.dart';
import 'package:music_list_app/pages/user_list_page.dart';
import 'package:music_list_app/services/my_controller.dart';

import 'create_account_page.dart';
import 'sign_in_account_page.dart';

class OpeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () => {
                MyController.signInWithGoogle().then((value) =>
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UserListPage())))
              },
              child: Text('Sign In With Google'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CreateAccountPage())),
              child: Text('Create Account'),
            ),
            FlatButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SignInAccountPage())),
                child: Text('Sign In'))
          ],
        ),
      ),
    );
  }
}
