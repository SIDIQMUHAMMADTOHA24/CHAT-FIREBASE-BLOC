import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secure_chat/app.dart';
import 'package:secure_chat/core/di/injection.dart';
import 'package:secure_chat/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUpDependencies();
  runApp(MyApp());
}
