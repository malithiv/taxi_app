import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/PostHireScreen.dart';

class MyHiresScreen extends StatelessWidget {
  const MyHiresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildMyHiresContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      floatingActionButton: _buildFloatingActionButton(context), // Add this
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Add this
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PostHireScreen()),
        );
      },
      child: Container(
        width: 56,
        height: 56,
        margin: const EdgeInsets.only(top: 32),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1B9AF5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 107,
      decoration: const BoxDecoration(
        color: Color(0xFF023047),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29),
          child: Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Text(
                'My Hires',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyHiresContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildActiveHireCard(),
        const SizedBox(height: 16),
        _buildCompletedHireCard(),
        const SizedBox(height: 16),
        _buildCompletedHireCard(),
      ],
    );
  }

  Widget _buildActiveHireCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF16A34A), width: 2),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Hire',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'In Progress',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: const Color(0xFF16A34A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDriverInfo(),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildLocationRow('From', '123 Malabe Central Road, Malabe'),
          const SizedBox(height: 8),
          _buildLocationRow('To', '45 Temple Road, Katharagama'),
          const SizedBox(height: 12),
          _buildVehicleInfo('Toyota Prius - WP CAB 1234'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined, size: 14),
                  label: Text(
                    'Call Driver',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1B9AF5),
                    side: const BorderSide(color: Color(0xFF1B9AF5)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.navigation_outlined, size: 14),
                  label: Text(
                    'Track',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B9AF5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedHireCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '23 Feb, 2025',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Completed',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDriverInfo(),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildLocationRow('From', '78 Galle Road, Colombo 03'),
          const SizedBox(height: 8),
          _buildLocationRow('To', '256 Beach Road, Negombo'),
          const SizedBox(height: 12),
          _buildVehicleInfo('Honda Vezel - WP CAB 5678'),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.star_border, size: 14),
              label: Text(
                'Rate Driver',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1B9AF5),
                side: const BorderSide(color: Color(0xFF1B9AF5)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF1B9AF5), width: 2),
            image: const DecorationImage(
              image: AssetImage('assets/images/driver.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Driver',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Color(0xFFFACC15)),
                const SizedBox(width: 4),
                Text(
                  '4.8',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationRow(String label, String address) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, size: 14),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              address,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: const Color(0xFF4B5563),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleInfo(String vehicleDetails) {
    return Row(
      children: [
        const Icon(Icons.directions_car_outlined, size: 14),
        const SizedBox(width: 12),
        Text(
          vehicleDetails,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: const Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, Icons.home_outlined, 'Home', false),
          _buildNavItem(context, 1, Icons.history, 'History', false),
          const SizedBox(width: 60), // Add this space for the FAB
          _buildNavItem(context, 2, Icons.map, 'My Hires', true),
          _buildNavItem(context, 3, Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/chome');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/chistory');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/cprofile');
              break;
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? const Color(0xFF1B9AF5) : const Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: isSelected ? const Color(0xFF1B9AF5) : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}