import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/OTPVerificationScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isCustomer = true;
  bool isLogin = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  int selectedUserType = 0; // 0 for Normal Customer, 1 for Cab Service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background ellipses
            Positioned(
              top: -160,
              left: 72,
              child: Container(
                width: 340,
                height: 277,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x101B9AF5),
                ),
              ),
            ),
            Positioned(
              top: -203,
              left: -129,
              child: Container(
                width: 412,
                height: 406,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x101B9AF5),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 61),
                  // Header text
                  Text(
                    isLogin ? 'Hello,\nWelcome Back!' : 'Create account',
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 0.93,
                    ),
                  ),

                  const SizedBox(height: 174),

                  // Customer/Driver toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildToggleButton(
                        title: 'Customer',
                        isSelected: isCustomer,
                        onTap: () => setState(() => isCustomer = true),
                      ),
                      const SizedBox(width: 16),
                      _buildToggleButton(
                        title: 'Driver',
                        isSelected: !isCustomer,
                        onTap: () => setState(() => isCustomer = false),
                      ),
                    ],
                  ),

                  const SizedBox(height: 37),

                  // Main card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Login/Signup tabs
                        Row(
                          children: [
                            _buildTabButton(
                              title: 'Login',
                              isSelected: isLogin,
                              onTap: () => setState(() => isLogin = true),
                            ),
                            const SizedBox(width: 16),
                            _buildTabButton(
                              title: 'Sign Up',
                              isSelected: !isLogin,
                              onTap: () => setState(() => isLogin = false),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Email input
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email or Phone Number',
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 14,
                              color: const Color(0xFF6B7280),
                            ),
                            prefixIcon: const Icon(Icons.email_outlined, size: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Password input
                        TextFormField(
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 14,
                              color: const Color(0xFF6B7280),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline, size: 14),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                size: 16,
                              ),
                              onPressed: () => setState(() => obscurePassword = !obscurePassword),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                          ),
                        ),

                        if (!isLogin) ...[
                          const SizedBox(height: 16),
                          // Confirm Password input (only for signup)
                          TextFormField(
                            obscureText: obscureConfirmPassword,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                color: const Color(0xFF6B7280),
                              ),
                              prefixIcon: const Icon(Icons.lock_outline, size: 14),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  size: 16,
                                ),
                                onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          // User type selection (only for signup)
                          Row(
                            children: [
                              Radio(
                                value: 0,
                                groupValue: selectedUserType,
                                onChanged: (value) => setState(() => selectedUserType = value as int),
                                activeColor: const Color(0xFF1B9AF5),
                              ),
                              Text(
                                'Normal Customer',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedUserType,
                                onChanged: (value) => setState(() => selectedUserType = value as int),
                                activeColor: const Color(0xFF1B9AF5),
                              ),
                              Text(
                                'Cab Service',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                        ],

                        if (isLogin) ...[
                          const SizedBox(height: 16),
                          // Remember me and Forgot Password (only for login)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  Text(
                                    'Remember me',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: const Color(0xFF4B5563),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color(0xFF219EBC),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 16),

                        // Action button
                        // Inside your AuthScreen class, update the action button's onPressed callback:

// Action button
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!isLogin) {
                                // For sign up, navigate to OTP verification
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OTPVerificationScreen(
                                      phoneNumber: "+1 (***) *** - 4589", // Replace with actual phone number
                                    ),
                                  ),
                                );
                              } else {
                                // Add login logic here
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B9AF5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              isLogin ? 'Login' : 'Sign Up',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom prompt
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 45,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Color(0xFFF3F4F6)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? "Don't have an account? " : "Already have an account? ",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: const Color(0xFF4B5563),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => isLogin = !isLogin),
                      child: Text(
                        isLogin ? 'Sign up' : 'Login',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: const Color(0xFF1B9AF5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets remain the same as in the previous implementation
  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 163.5,
        height: 97,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? const Color(0xFF5B8FFF) : const Color(0xFFE5E7EB),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              title == 'Customer' ? Icons.person_outline : Icons.drive_eta_outlined,
              color: isSelected ? const Color(0xFF5B8FFF) : const Color(0xFF9CA3AF),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF5B8FFF) : const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 138.5,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF219EBC) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? const Color(0xFF219EBC) : const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}