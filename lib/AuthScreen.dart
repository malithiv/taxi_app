import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/OTPVerificationScreen.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'CustomerHomeScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // In _AuthScreenState class
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  bool isCustomer = true;
  bool isLogin = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  int selectedUserType = 0; // 0 for Normal Customer, 1 for Cab Service, 2 for Business Customer


  // Format phone number for API
  String formatPhoneNumber(String phoneNumber) {
    // Remove spaces, dashes, etc.
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // If the number starts with 0, remove it (assuming Sri Lankan format)
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    // Return international format
    return '94$cleaned';
  }

// Generate OTP
  String generateOTP() {
    Random random = Random();
    int otp = random.nextInt(9000) + 1000; // 4-digit code between 1000-9999
    return otp.toString();
  }

// Login function
  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://145.223.21.62:5050/customers/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': formatPhoneNumber(phoneController.text),
          'password': passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Navigate to home page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerHomeScreen(),
          ),
        );
      } else {
        setState(() {
          errorMessage = data['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Connection error: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

// Get customer type string based on selection
  String getCustomerTypeString() {
    switch (selectedUserType) {
      case 0:
        return 'normal_customer';
      case 1:
        return 'cab_service';
      case 2:
        return 'business_customer';
      default:
        return 'normal_customer';
    }
  }

// Register function
  Future<void> register() async {
    // Validate passwords match
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match';
      });
      return;
    }

    // Validate phone number
    if (phoneController.text.isEmpty) {
      setState(() {
        errorMessage = 'Phone number is required';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // First, register the user in your backend
      final registrationResponse = await http.post(
        Uri.parse('http://145.223.21.62:5050/customers/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': formatPhoneNumber(phoneController.text),
          'password': passwordController.text,
          'customer_type': getCustomerTypeString(),
        }),
      );

      final data = jsonDecode(registrationResponse.body);

      if (registrationResponse.statusCode == 201) {
        // User registered successfully, now generate and send OTP
        String otp = generateOTP(); // Generate a 4-digit OTP
        String fullPhoneNumber = formatPhoneNumber(phoneController.text);

        // Log for debugging
        print('User registered with ID: ${data['customerId']}');
        print('Phone number: $fullPhoneNumber');
        print('Generated OTP: $otp');

        // Notify.lk API credentials
        const String userId = '28446';  // Replace with your actual credentials
        const String apiKey = 'Qfc88oVCjT7zGQhVbKk9';  // Replace with your actual credentials
        const String senderId = 'NotifyDEMO';  // Replace with your actual credentials

        // Notify.lk API endpoint
        const String url = 'https://app.notify.lk/api/v1/send';

        // Prepare the message content
        String message = 'Your verification code is $otp. Please use this to verify your account.';

        // API call parameters
        final Map<String, String> queryParams = {
          'user_id': userId,
          'api_key': apiKey,
          'sender_id': senderId,
          'to': fullPhoneNumber.replaceAll('+', ''), // Ensure the phone number is in 947XXXXXXXX format
          'message': message,
        };

        try {
          // Send OTP via Notify.lk API
          final notifyResponse = await http.post(
            Uri.parse(url).replace(queryParameters: queryParams),
          );

          // Log response for debugging
          print('Notify.lk API response: ${notifyResponse.body}');

          if (notifyResponse.statusCode == 200) {
            final notifyData = notifyResponse.body;

            // Check if OTP was sent successfully
            if (notifyData.contains('"status":"success"')) {
              // Navigate to OTP verification screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPVerificationScreen(
                    phoneNumber: fullPhoneNumber,
                    otp: otp,
                    userId: data['customerId'], // Pass the user ID for verification later
                    customerType: getCustomerTypeString(), // Pass the customer type to OTP screen
                  ),
                ),
              );
            } else {
              setState(() {
                errorMessage = 'Failed to send verification code. Please try again.';
              });
            }
          } else {
            setState(() {
              errorMessage = 'Failed to send verification code. Status: ${notifyResponse.statusCode}';
            });
          }
        } catch (e) {
          setState(() {
            errorMessage = 'Error sending verification code: ${e.toString()}';
          });
        }
      } else {
        // Registration failed
        setState(() {
          errorMessage = data['message'] ?? 'Registration failed. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Connection error: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                  color: Color(0xFFC0D4FF),
                ),
              ),
            ),
            Positioned(
              top: -203,
              left: -129,
              child: Container(
                width: 470,
                height: 420,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF5B8FFF),
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

                  const SizedBox(height: 140),

                  // Customer/Driver toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildToggleButton(
                            title: 'Customer',
                            isSelected: isCustomer,
                            onTap: () => setState(() => isCustomer = true),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildToggleButton(
                            title: 'Driver',
                            isSelected: !isCustomer,
                            onTap: () => setState(() => isCustomer = false),
                          ),
                        ),
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
                            Expanded(
                              child: _buildTabButton(
                                title: 'Login',
                                isSelected: isLogin,
                                onTap: () => setState(() => isLogin = true),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTabButton(
                                title: 'Sign Up',
                                isSelected: !isLogin,
                                onTap: () => setState(() => isLogin = false),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Email input
                        TextFormField(
                          controller: phoneController,
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
                          controller: passwordController,
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
                            controller: confirmPasswordController,
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
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: selectedUserType,
                                onChanged: (value) => setState(() => selectedUserType = value as int),
                                activeColor: const Color(0xFF1B9AF5),
                              ),
                              Text(
                                'Business Customer',
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
                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text(
                              //     'Forgot Password?',
                              //     style: GoogleFonts.roboto(
                              //       fontSize: 14,
                              //       color: const Color(0xFF219EBC),
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 16),

                        // Action button
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : (isLogin ? login : register),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B9AF5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                              isLogin ? 'Login' : 'Sign Up',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        if (errorMessage != null && errorMessage!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            errorMessage!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
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

  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(14),
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