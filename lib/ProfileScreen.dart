import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildDriverStatus(),
            _buildVehicleInformation(),
            _buildTripStatistics(),
            _buildSettingsButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF023047),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Column(
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
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {},
                ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        minimumSize: const Size(0, 28),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: GoogleFonts.roboto(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverStatus() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver Status',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusCard(
                  'Total Earnings',
                  '\$24,567',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusCard(
                  'This Week',
                  '\$785',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, String amount) {
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
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
              'Vehicle Information',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Current Vehicle', 'Toyota Camry 2021'),
            const SizedBox(height: 16),
            _buildInfoRow('Location', 'Colombo'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B9AF5),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text(
                  'Add New Vehicle',
                  style: GoogleFonts.roboto(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripStatistics() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
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
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatisticItem('Total Trips', '2,145'),
                ),
                Expanded(
                  child: _buildStatisticItem('Total Distance', '34,567 km'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSettingButton('Support Center'),
          const SizedBox(height: 8),
          _buildSettingButton('Terms and Conditions'),
          const SizedBox(height: 8),
          _buildSettingButton(
            'Logout',
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        if (label == 'Current Vehicle')
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.black,
          ),
      ],
    );
  }

  Widget _buildStatisticItem(String label, String value) {
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
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingButton(String title, {bool isLogout = false}) {
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
          textAlign: isLogout ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: isLogout ? const Color(0xFFDC2626) : const Color(0xFF374151),
          ),
        ),
        trailing: isLogout ? null : const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          // Handle button tap
        },
      ),
    );
  }
}