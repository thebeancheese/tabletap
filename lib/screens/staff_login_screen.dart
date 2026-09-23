import 'package:flutter/material.dart';
import 'staff_dashboard_screen.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final TextEditingController _staffIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? _errorMessage;

  void _login() {
    final staffId = _staffIdController.text.trim();
    final password = _passwordController.text;

    // Simulated staff credentials for the prototype.
    if (staffId == 'staff' && password == 'tabletap123') {
      setState(() {
        _errorMessage = null;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const StaffDashboardScreen(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Incorrect Staff ID or password.';
      });
    }
  }

  void _showPrototypeMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _staffIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8EF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: Color(0xFF290E07),
                      ),
                    ),
                  ),
                  const Text(
                    'TableTap',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFAE3C00),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // Title
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login to your Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Staff ID
                    SizedBox(
                      height: 46,
                      child: TextField(
                        controller: _staffIdController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Staff ID',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFB0B0B0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFFE4E0DB),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFFAE3C00),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Password
                    SizedBox(
                      height: 46,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onSubmitted: (_) {
                          _login();
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFB0B0B0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          suffixIcon: TextButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: Text(
                              _obscurePassword ? 'Show' : 'Hide',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFAE3C00),
                              ),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFFE4E0DB),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFFAE3C00),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 2),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _showPrototypeMessage(
                            'Password recovery is not available in this prototype.',
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFAE3C00),
                          ),
                        ),
                      ),
                    ),

                    // Error message
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFFD32F2F),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Sign in button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAE3C00),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // PIN option
                    TextButton(
                      onPressed: () {
                        _showPrototypeMessage(
                          'PIN login is not available in this prototype.',
                        );
                      },
                      child: const Text(
                        'Log in with PIN instead',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFAE3C00),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Demo account box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFE4E0DB),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Demo Staff Account',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF290E07),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Staff ID: staff',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF666666),
                            ),
                          ),
                          Text(
                            'Password: tabletap123',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 5),

                    const Text(
                      'Staff access only',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF726C6C),
                      ),
                    ),

                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}