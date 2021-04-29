import 'package:flutter/material.dart';
import 'package:music_list_app/pages/user_list_page.dart';
import 'package:music_list_app/pages/opening_page.dart';
import 'package:music_list_app/services/my_controller.dart';
import 'package:firebase_core/firebase_core.dart';

TextTheme _textTheme(Color color) => TextTheme(
      headline1: TextStyle(color: color),
      headline2: TextStyle(color: color),
      headline3: TextStyle(color: color),
      headline4: TextStyle(color: color),
      headline5: TextStyle(color: color),
      headline6: TextStyle(color: color, fontSize: 24.0),
      subtitle1: TextStyle(color: color, fontSize: 18.0),
      subtitle2: TextStyle(color: color),
      bodyText1: TextStyle(color: color),
      bodyText2: TextStyle(color: color, fontSize: 18.0),
      button: TextStyle(color: color),
      caption: TextStyle(color: color),
      overline: TextStyle(color: color),
    );

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();

    return MaterialApp(
        title: 'Music Lists',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
            buttonColor: Color(0xFF54bf54),
            accentColor: Color(0xFF54bf54),
            appBarTheme: AppBarTheme(color: Color(0xFF404040)),
            canvasColor: Color(0xFF323232),
            dividerColor: Color(0xFF404040),
            inputDecorationTheme: InputDecorationTheme(
                hoverColor: Color(0xFF54bf54), focusColor: Color(0xFF54bf54)),
            scaffoldBackgroundColor: Color(0xFF323232),
            textTheme: _textTheme(Colors.white),
            unselectedWidgetColor: Color(0xFF3d8f3d)),
        theme: ThemeData(
            accentColor: Color(0xFFfa7921),
            appBarTheme: AppBarTheme(color: Color(0xFF2a0c4e)),
            canvasColor: Color(0xFFdce0d9),
            dividerColor: Color(0xFF2a0c4e),
            inputDecorationTheme: InputDecorationTheme(
                hoverColor: Color(0xFFfa7921), focusColor: Color(0xFFfa7921)),
            scaffoldBackgroundColor: Color(0xFFdce0d9),
            textTheme: _textTheme(Color(0xFF33658a)),
            unselectedWidgetColor: Color(0xFFf26419)),
        home: Builder(builder: (context) => ListTileTheme(iconColor:
    Theme.of(context).iconTheme.color, child:
        FutureBuilder<FirebaseApp>(
          future: firebaseInitialization,
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('An error occurred'),
                ),
              );
            }
            if (snapshot.hasData) {
              return MyController.isSignedIn() ? UserListPage() : OpeningPage();
            }
            return Scaffold();
          },
        )
          ,),),
    );
  }
}
