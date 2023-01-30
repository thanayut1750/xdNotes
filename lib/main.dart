import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xdnotes/firebase_options.dart';
import 'package:xdnotes/views/login_view.dart';
import 'package:xdnotes/views/register_view.dart';
import 'package:xdnotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          final user = FirebaseAuth.instance.currentUser;
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (user != null) {
                if (user.emailVerified) {
                  print("email is verified");
                } else {
                  return const LoginView();
                }
              } else {
                return const LoginView();
              }
              return const Text("Done");
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
