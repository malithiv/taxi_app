import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isCarSelected = true;
  bool isVanSelected = false;
  bool isBusSelected = false;
  String selectedLocation = 'Colombo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLocationSection(),
                  const SizedBox(height: 16),
                  _buildVehicleTypesSection(),
                  const SizedBox(height: 24),
                  _buildVehicleDetailsSection(),
                  const SizedBox(height: 24),
                  _buildLocationDetailsSection(),
                  const SizedBox(height: 24),
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
      height: 128,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF023047),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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

  Widget _buildLocationSection() {
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
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Angoda',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleTypesSection() {
    return Column(
      children: [
        _buildVehicleTypeSwitch('Car', isCarSelected, (value) {
          setState(() => isCarSelected = value);
        }),
        const SizedBox(height: 16),
        _buildVehicleTypeSwitch('Van', isVanSelected, (value) {
          setState(() => isVanSelected = value);
        }),
        const SizedBox(height: 16),
        _buildVehicleTypeSwitch('Bus', isBusSelected, (value) {
          setState(() => isBusSelected = value);
        }),
      ],
    );
  }

  Widget _buildVehicleTypeSwitch(String type, bool value, Function(bool) onChanged) {
    return Container(
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
            type,
            style: GoogleFonts.roboto(fontSize: 14),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1B9AF5),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleDetailsSection() {
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
          _buildDropdownField('Mini Car'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'License Plate',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4B5563),
                ),
              ),
              Text(
                'XYZ 789',
                style: GoogleFonts.roboto(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vehicle Color',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4B5563),
                ),
              ),
              Text(
                'Silver',
                style: GoogleFonts.roboto(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetailsSection() {
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
          _buildDropdownField('Colombo'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Location',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4B5563),
                ),
              ),
              Text(
                'Colombo',
                style: GoogleFonts.roboto(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String value) {
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
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B9AF5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          'Edit Profile',
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 'Home', true),
          _buildNavItem(Icons.history, 'History', false),
          _buildNavItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
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