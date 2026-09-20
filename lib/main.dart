import 'package:flutter/material.dart';
import 'screens/role_selection_screen.dart';

void main() {
  runApp(const TableTapApp());
}

class TableTapApp extends StatelessWidget {
  const TableTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableTap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFAE3C00),
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF8EF),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}