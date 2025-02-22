// otp_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/ProfileCreationScreen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    5,
        (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    5,
        (index) => FocusNode(),
  );

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
    if (value.length == 1 && index < 4) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
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
                  text: "We've sent a verification code to your phone number\n",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                      (index) => SizedBox(
                    width: 52,
                    height: 52,
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
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF1B9AF5), width: 2),
                        ),
                      ),
                      onChanged: (value) => nextField(value, index),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Verify Button
              // In your OTP verification screen, update the verify button:

// Verify Button
              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton(
                  onPressed: () {
                    String otp = otpControllers.map((controller) => controller.text).join();
                    if (otp.length == 5) {
                      // Navigate to profile creation screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileCreationScreen(
                            isDriver: false, // Pass this based on the selection from auth screen
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter complete OTP'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B9AF5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Verify',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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