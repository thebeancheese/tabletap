import 'package:flutter/material.dart';

class StaffLoginScreen extends StatelessWidget {
  const StaffLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Login'),
      ),
      body: const Center(
        child: Text(
          'Staff login will go here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}