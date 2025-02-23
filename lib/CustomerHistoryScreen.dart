import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/MyHiresScreen.dart';
import 'package:taxi_app/PostHireScreen.dart';

class CustomerHistoryScreen extends StatelessWidget {
  const CustomerHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildHistoryContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                'History',
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

  Widget _buildHistoryContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHistoryCard(
          date: '23 Feb, 2025',
          driverName: 'John Driver',
          rating: 4.8,
          from: '123 Malabe Central Road, Malabe',
          to: '45 Temple Road, Katharagama',
          vehicle: 'Toyota Prius - WP CAB 1234',
          status: 'Completed',
          amount: 'Rs. 2,500',
        ),
        const SizedBox(height: 16),
        _buildHistoryCard(
          date: '22 Feb, 2025',
          driverName: 'Mike Smith',
          rating: 4.5,
          from: '78 Galle Road, Colombo 03',
          to: '256 Beach Road, Negombo',
          vehicle: 'Honda Vezel - WP CAB 5678',
          status: 'Cancelled',
          amount: 'Rs. 0',
          isCancelled: true,
        ),
        const SizedBox(height: 16),
        _buildHistoryCard(
          date: '21 Feb, 2025',
          driverName: 'David Wilson',
          rating: 5.0,
          from: '42 Hill Street, Kandy',
          to: '89 Lake Road, Nuwara Eliya',
          vehicle: 'Wagon R - WP CAB 9012',
          status: 'Completed',
          amount: 'Rs. 3,200',
        ),
      ],
    );
  }

  Widget _buildHistoryCard({
    required String date,
    required String driverName,
    required double rating,
    required String from,
    required String to,
    required String vehicle,
    required String status,
    required String amount,
    bool isCancelled = false,
  }) {
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
                date,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCancelled
                      ? const Color(0xFFFEE2E2)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: isCancelled
                        ? const Color(0xFFDC2626)
                        : const Color(0xFF4B5563),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDriverInfo(driverName, rating),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildLocationRow('From', from),
          const SizedBox(height: 8),
          _buildLocationRow('To', to),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildVehicleInfo(vehicle),
              Text(
                amount,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1B9AF5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo(String name, double rating) {
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
              name,
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
                  rating.toString(),
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
        Expanded(
          child: Column(
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
          _buildNavItem(context, 1, Icons.history, 'History', true),
          const SizedBox(width: 60),
          _buildNavItem(context, 2, Icons.map, 'My Hires', false),
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
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHiresScreen()),
              );
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
}