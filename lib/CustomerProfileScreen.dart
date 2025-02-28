import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CabServicePendingScreen.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(  // Added this
        child: Column(
          children: [
            _buildHeader(),
            _buildProfileStats(),
            _buildSettings(context),
            const SizedBox(height: 80),  // Added padding for FAB
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(  // Removed fixed height
        color: Color(0xFF023047),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Added this to prevent expansion
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
              const SizedBox(height: 16),
              Row(
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
                  Expanded(  // Added this to prevent text overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,  // Added this
                      children: [
                        Text(
                          'Michael Anderson',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '(2,145 trips)',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStats() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver Status',
            style: GoogleFonts.roboto(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total Earnings', '\$24,567'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('This Week', '\$785'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTripStatistics(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String amount) {
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
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: const Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripStatistics() {
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
          Text(
            'Trip Statistics',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTripStat('Total Trips', '2,145'),
              ),
              Expanded(
                child: _buildTripStat('Total Distance', '34,567 km'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSettingButton(
            'Support Center',
            onTap: () {},
            showArrow: true,
          ),
          const SizedBox(height: 16),
          _buildSettingButton(
            'Logout',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CabServicePendingScreen(// Replace with actual phone number
                  ),
                ),
              );
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingButton(
      String title, {
        required VoidCallback onTap,
        bool showArrow = false,
        bool isLogout = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: isLogout ? const Color(0xFFFEF2F2) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          textAlign: showArrow ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: isLogout ? const Color(0xFFDC2626) : const Color(0xFF374151),
          ),
        ),
        trailing: showArrow ? const Icon(Icons.arrow_forward_ios, size: 14) : null,
        onTap: onTap,
      ),
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
          const SizedBox(width: 60),
          _buildNavItem(context, 2, Icons.map, 'My Hires', false),
          _buildNavItem(context, 3, Icons.person_outline, 'Profile', true),
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
            case 2:
              Navigator.pushReplacementNamed(context, '/myhires');
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

  Widget _buildFloatingActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/posthire');
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
}