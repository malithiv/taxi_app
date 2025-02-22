// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/AuthScreen.dart';
import 'package:taxi_app/LoginScreen.dart';  // Add this import

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background ellipses (same as before)
          Positioned(
            top: -364,
            right: -254,
            child: Container(
              width: 498,
              height: 576,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x101B9AF5),
              ),
            ),
          ),
          // Other ellipses remain the same...

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Welcome text (same as before)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Welcome to Our Community',
                    style: GoogleFonts.inter(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF023047),
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Image and description remain the same...
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Image.asset(
                    'assets/images/onboarding.png',
                    width: 366,
                    height: 426,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 34),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 83),
                  child: Text(
                    'Join a community where every ride is safe, reliable, and comfortable',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF736B66),
                      height: 1.125,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 23),

                // Updated Continue button with navigation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 61),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B9AF5),
                      minimumSize: const Size(293, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Let's continue",
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
    );
  }
}