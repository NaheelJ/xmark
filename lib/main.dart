import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xmark/View/dashboard.dart';
import 'package:xmark/Viwe%20Model/estimation_provider.dart';
import 'package:xmark/Viwe%20Model/manual_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xmark/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Estimation>(create: (context) => Estimation()),
        ChangeNotifierProvider<ManualProvider>(create: (context) => ManualProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
