import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_repository.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _authRepository.signInWithGoogle();
            context.read<AuthBloc>().add(LoggedIn());
          },
          child: Text("Sign in with Google"),
        ),
      ),
    );
  }
}
