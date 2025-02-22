import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditDriverProfileScreen extends StatefulWidget {
  const EditDriverProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditDriverProfileScreen> createState() => _EditDriverProfileScreenState();
}

class _EditDriverProfileScreenState extends State<EditDriverProfileScreen> {
  String currentVehicle = 'Mini Car';
  String selectedLocation = 'Colombo';
  Map<String, bool> vehicleTypes = {
    'Car': true,
    'Van': false,
    'Bus': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                children: [
                  _buildTopSection(),
                  const SizedBox(height: 16),
                  _buildVehicleTypesList(),
                  const SizedBox(height: 24),
                  _buildVehicleDetailsCard(),
                  const SizedBox(height: 24),
                  _buildLocationCard(),
                  const SizedBox(height: 43),
                  _buildEditProfileButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 128,
      decoration: const BoxDecoration(
        color: Color(0xFF023047),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Michael Anderson',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '(2,143 trips)',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Vehicle Types',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Text(
              'Location',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Angoda',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleTypesList() {
    return Column(
      children: vehicleTypes.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            height: 48,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      vehicleTypes[entry.key] = value;
                    });
                  },
                  activeColor: const Color(0xFF1B9AF5),
                  activeTrackColor: const Color(0xFF1B9AF5),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVehicleDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Details',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdown(currentVehicle, ['Mini Car', 'Sedan', 'SUV']),
          const SizedBox(height: 16),
          _buildDetailRow('License Plate', 'XYZ 789'),
          const SizedBox(height: 12),
          _buildDetailRow('Vehicle Color', 'Silver'),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdown(selectedLocation, ['Colombo', 'Angoda', 'Malabe']),
          const SizedBox(height: 16),
          _buildDetailRow('Location', 'Colombo'),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF6B7280)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: GoogleFonts.roboto(fontSize: 16),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: const Color(0xFF4B5563),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfileButton() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B9AF5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          'Edit Profile',
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(Icons.home_outlined, 'Home', true),
          _buildNavBarItem(Icons.history, 'History', false),
          _buildNavBarItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pop(context);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? const Color(0xFF5B8FFF) : const Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: isSelected ? const Color(0xFF5B8FFF) : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}