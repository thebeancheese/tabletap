import 'package:flutter/material.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8EF),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'TableTap',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFFAE3C00),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Log out',
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Color(0xFF290E07),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: Color(0xFFAE3C00),
              ),
              SizedBox(height: 16),
              Text(
                'Incoming Orders',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Staff order management will be added next.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}