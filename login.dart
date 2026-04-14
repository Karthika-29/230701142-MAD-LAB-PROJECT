import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("TrendSpot Login 🔥",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

              TextField(
                controller: email,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextField(
                controller: password,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: login,
                child: Text("Login"),
              ),

              ElevatedButton(
                onPressed: signup,
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}