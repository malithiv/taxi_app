import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  bool showAvailableHires = true;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabs(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHireRequest(
                  requestNo: '2024',
                  from: '123 Malabe Central Road, Malabe',
                  to: '45 Temple Road, Katharagama',
                  vehicle: 'Wagon R',
                  phoneNumber: '***-***6789',
                  isHighlighted: false,
                ),
                const SizedBox(height: 16),
                _buildHireRequest(
                  requestNo: '2023',
                  from: '78 Galle Road, Colombo 03',
                  to: '256 Beach Road, Negombo',
                  vehicle: 'Toyota Prius',
                  phoneNumber: '***-***4321',
                  isHighlighted: true,
                ),
                const SizedBox(height: 16),
                _buildHireRequest(
                  requestNo: '2022',
                  from: '42 Hill Street, Kandy',
                  to: '89 Lake Road, Nuwara Eliya',
                  vehicle: 'Honda Vezel',
                  phoneNumber: '***-***8765',
                  isHighlighted: false,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: _buildFloatingActionButton(),
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
                'Michael Anderson',
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

  Widget _buildTabs() {
    return SizedBox(
      height: 47,
      child: Row(
        children: [
          _buildTab('Available Hires', true),
          _buildTab('My Hires', false),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showAvailableHires = title == 'Available Hires';
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected == showAvailableHires
                  ? const Color(0xFF165BF1)
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: isSelected == showAvailableHires
                  ? FontWeight.w500
                  : FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHireRequest({
    required String requestNo,
    required String from,
    required String to,
    required String vehicle,
    required String phoneNumber,
    required bool isHighlighted,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted
            ? Border.all(color: const Color(0xFFEAB308), width: 3)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Request #$requestNo',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFCE8),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Pending',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: const Color(0xFFA16207),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildLocationRow('From', from),
          const SizedBox(height: 8),
          _buildLocationRow('To', to),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.directions_car_outlined, size: 14),
              const SizedBox(width: 12),
              Text(
                vehicle,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4B5563),
                ),
              ),
              const SizedBox(width: 100),
              const Icon(Icons.phone_outlined, size: 14),
              const SizedBox(width: 12),
              Text(
                phoneNumber,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF4B5563),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: OutlinedButton.icon(
              onPressed: () {
                // Add call functionality
              },
              icon: const Icon(Icons.phone_outlined, size: 14),
              label: Text(
                'Call',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1B9AF5),
                side: const BorderSide(color: Color(0xFF1B9AF5)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              ),
            ),
          ),
        ],
      ),
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
          _buildNavItem(0, Icons.home_outlined, 'Home'),
          _buildNavItem(1, Icons.history, 'History'),
          const SizedBox(width: 60),
          _buildNavItem(2, Icons.map, 'My Hires'),
          _buildNavItem(3, Icons.person_outline, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
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

  Widget _buildFloatingActionButton() {
    return Container(
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
    );
  }
}