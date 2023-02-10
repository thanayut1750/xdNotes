// ignore_for_file: invalid_use_of_visible_for_testing_member, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xdnotes/constants/routes.dart';
import 'package:xdnotes/services/auth/bloc/auth_bloc.dart';
import 'package:xdnotes/services/auth/bloc/auth_event.dart';
import 'package:xdnotes/services/auth/bloc/auth_state.dart';
import 'package:xdnotes/services/auth/firebase_auth_provider.dart';
import 'package:xdnotes/views/login_view.dart';
import 'package:xdnotes/views/notes/create_update_note_view.dart';
import 'package:xdnotes/views/notes/notes_view.dart';
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
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
