import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/auth/login.dart';

class RouteGuard extends StatelessWidget {
  final Widget child;

  RouteGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return child;
        } else {
          return LoginScreen();
        }
      },
    );
  }
}