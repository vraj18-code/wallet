import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wallet/screens/Home%20screen.dart';
import 'package:wallet/screens/login_screen.dart';

import 'auth_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/wallet/wallet_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(_authRepository)..add(AppStarted()),
        ),
        BlocProvider<WalletBloc>(
          create: (context) => WalletBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Wallet App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return HomeScreen();
            } else if (state is AuthUnauthenticated) {
              return LoginScreen();
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
