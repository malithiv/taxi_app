import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/AuthScreen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background ellipse - Made responsive
          Positioned(
            top: -screenHeight * 0.25,
            right: -screenWidth * 0.35,
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x101B9AF5),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Top spacing
                    SizedBox(height: screenHeight * 0.04),

                    // Welcome text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Welcome to Our Community',
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.085,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF023047),
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    // Spacing
                    SizedBox(height: screenHeight * 0.03),

                    // Image section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: AspectRatio(
                        aspectRatio: 366/426,
                        child: Image.asset(
                          'assets/images/onboarding.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Spacing
                    SizedBox(height: screenHeight * 0.03),

                    // Description text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                      child: Text(
                        'Join a community where every ride is safe, reliable, and comfortable',
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF736B66),
                          height: 1.125,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Spacing
                    SizedBox(height: screenHeight * 0.03),

                    // Continue button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.15,
                        vertical: screenHeight * 0.02,
                      ),
                      child: SizedBox(
                        width: double.infinity,
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
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.018,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Let's continue",
                            style: GoogleFonts.roboto(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Bottom spacing
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}