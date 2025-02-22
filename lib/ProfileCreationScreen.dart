// profile_creation_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:taxi_app/HomeScreen.dart';

class ProfileCreationScreen extends StatefulWidget {
  final bool isDriver;

  const ProfileCreationScreen({
    Key? key,
    required this.isDriver,
  }) : super(key: key);

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  File? _image;
  bool termsAccepted = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.isDriver ? 'Driver Profile Creation' : 'Customer Profile Creation',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: const Color(0xFFE5E7EB),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Photo Section
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF3F4F6),
                        border: Border.all(
                          color: const Color(0xFF1B9AF5),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: _image == null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            size: 32,
                            color: Color(0xFF6B7280),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add Photo',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      )
                          : ClipOval(
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Personal Information Section
                Text(
                  'Personal Information',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                // Form Fields
                TextFormField(
                  decoration: _buildInputDecoration('Full Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  decoration: _buildInputDecoration('Date of Birth')
                      .copyWith(suffixIcon: const Icon(Icons.calendar_today, size: 16)),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    // Handle date selection
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  decoration: _buildInputDecoration('Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  decoration: _buildInputDecoration('Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  decoration: _buildInputDecoration('Home Address'),
                  maxLines: 3,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 36),

                // Terms and Conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'I agree to the Terms and Conditions and Privacy Policy. I understand that my information will be used as described on this page.',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Create Profile Button
                // In your profile creation screen, update the create profile button:

                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (!termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please accept the terms and conditions'),
                            ),
                          );
                          return;
                        }
                        // Navigate to home screen
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                              (route) => false, // This will remove all previous routes
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B9AF5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Create Profile',
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
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.roboto(
        fontSize: 14,
        color: const Color(0xFF6B7280),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF6B7280)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF6B7280)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1B9AF5)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}