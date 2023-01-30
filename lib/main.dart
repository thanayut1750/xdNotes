import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xdnotes/firebase_options.dart';
import 'package:xdnotes/views/login_view.dart';
import 'package:xdnotes/views/register_view.dart';

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
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final currentUser = FirebaseAuth.instance.currentUser;
              // if (currentUser?.emailVerified ?? false) {
              //   // print('You are a verified user');
              //   return const Text('Done');
              // } else {
              //   return VerifyEmailView();
              // }
              return const LoginView();
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}

