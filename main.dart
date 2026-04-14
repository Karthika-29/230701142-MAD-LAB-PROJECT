import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "",
      authDomain: "trendspot-22085.firebaseapp.com",
      projectId: "trendspot-22085",
      storageBucket: "trendspot-22085.firebasestorage.app",
  messagingSenderId: "1030555954341",
  appId: "1:1030555954341:web:4288f5826be20ff0b0f14c",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // start screen
      initialRoute: '/',

      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
