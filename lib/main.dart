import 'package:flutter/material.dart';
import 'package:gridly2/firebase_options.dart';
import 'package:gridly2/home_page.dart';
import 'package:gridly2/login_page.dart';
import 'package:gridly2/register_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gridly',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
      routes: {
        '/home/': (context) => const HomePage(),
        '/login/': (context) => const LoginPage(),
        '/signup/': (context) => const SignUpPage(),
      },
    );
  }
}
