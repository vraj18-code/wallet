import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'firebase_options.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}
