// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pert6/pages/login_page.dart';
import 'package:pert6/pages/splash_page.dart';
import 'package:pert6/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.redAccent,
              ),
            ),
            errorStyle: TextStyle(color: Colors.red),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, 
                foregroundColor: Colors.white),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
