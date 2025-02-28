// otp_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/ProfileCreationScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String otp;
  final int userId;
  final String customerType;

  const OTPVerificationScreen({
    Key? key,
    required this.phoneNumber,
    required this.otp,
    required this.userId,
    required this.customerType
  }) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );

  bool isVerifying = false;
  String? errorMessage;

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void nextField(String value, int index) {
    if (value.length == 1 && index < 3) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  // Update verification status in database
  Future<bool> updateVerificationStatus() async {
    try {
      final response = await http.post(
        Uri.parse('http://145.223.21.62:5050/customers/otp/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'verification_status': 'success',
          'customer_type': widget.customerType,
        }),
      );

      if (response.statusCode == 200) {
        print('Verification status updated successfully');
        return true;
      } else {
        print('Failed to update verification status: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating verification status: $e');
      return false;
    }
  }

  // Verify OTP function
  void verifyOTP() async {
    setState(() {
      isVerifying = true;
      errorMessage = null;
    });

    String enteredOTP = otpControllers.map((controller) => controller.text).join();

    // Validate OTP length
    if (enteredOTP.length != 4) {
      setState(() {
        isVerifying = false;
        errorMessage = 'Please enter complete 4-digit OTP';
      });
      return;
    }

    // Compare with expected OTP
    if (enteredOTP == widget.otp) {
      // OTP is correct, update verification status in database
      bool updated = await updateVerificationStatus();

      if (updated) {
        // Navigate to profile creation
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileCreationScreen(
              isDriver: false,
            ),
          ),
        );
      } else {
        // Failed to update verification status
        setState(() {
          isVerifying = false;
          errorMessage = 'Failed to verify account. Please try again.';
        });
      }
    } else {
      // OTP is incorrect
      setState(() {
        isVerifying = false;
        errorMessage = 'Invalid OTP. Please try again.';

        // Clear all OTP fields
        for (var controller in otpControllers) {
          controller.clear();
        }

        // Set focus to first field
        if (focusNodes.isNotEmpty) {
          focusNodes[0].requestFocus();
        }
      });
    }
  }

  // Resend OTP function
  void resendOTP() {
    // Clear existing OTP fields
    for (var controller in otpControllers) {
      controller.clear();
    }

    // Set focus to first field
    if (focusNodes.isNotEmpty) {
      focusNodes[0].requestFocus();
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP resent successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear any error message
    setState(() {
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Verify Your Number',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 12),

              Text.rich(
                TextSpan(
                  text: "We've sent a 4-digit verification code to\n",
                  children: [
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4B5563),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 42),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 60,
                    height: 60,
                    child: TextFormField(
                      controller: otpControllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF1B9AF5), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        nextField(value, index);

                        // Auto-verify when all fields are filled
                        if (index == 3 && value.length == 1) {
                          // Check if all fields are filled
                          bool allFilled = otpControllers.every(
                                  (controller) => controller.text.length == 1
                          );

                          if (allFilled) {
                            verifyOTP();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),

              // Error message
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Center(
                    child: Text(
                      errorMessage!,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 32),

              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton(
                  onPressed: isVerifying ? null : verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B9AF5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    disabledBackgroundColor: const Color(0xFF1B9AF5).withOpacity(0.6),
                  ),
                  child: isVerifying
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    'Verify',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Resend OTP option
              Center(
                child: TextButton(
                  onPressed: resendOTP,
                  child: Text(
                    'Resend OTP',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1B9AF5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Having trouble? ',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: const Color(0xFF4B5563),
              ),
            ),
            TextButton(
              onPressed: () {
                // Add contact support logic
              },
              child: Text(
                'Contact Support',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1B9AF5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}