import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:square_ghost/auth/logedin_checking_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square Ghost',
      theme: ThemeData(
        
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LogedinCheckingScreen(),
    );
  }
}
