import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabServicePendingScreen extends StatefulWidget {
  const CabServicePendingScreen({Key? key}) : super(key: key);

  @override
  State<CabServicePendingScreen> createState() => _CabServicePendingScreenState();
}

class _CabServicePendingScreenState extends State<CabServicePendingScreen> {
  String selectedFilter = 'All';
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          _buildHeader(),
          _buildDateRange(),
          Expanded(
            child: _buildRequestsList(),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  _buildFilterButton('All', true),
                  const SizedBox(width: 12),
                  _buildFilterButton('Pending', false),
                  const SizedBox(width: 12),
                  _buildFilterButton('Completed', false),
                  const SizedBox(width: 12),
                  _buildFilterButton('Cancelled', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRange() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Date Range',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: const Color(0xFF4B5563),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Text(
              'Last 7 days',
              style: TextStyle(
                color: Color(0xFF1B9AF5),
                fontSize: 14,
              ),
            ),
            label: const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Color(0xFF1B9AF5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsList() {
    return ListView(
      children: [
        _buildRequestItem(
          requestNo: '5024',
          address: '716 Middle Central Road, Midvale',
          region: 'Region II',
        ),
        _buildRequestItem(
          requestNo: '5023',
          address: '235 Beach Road, Columbus',
          region: 'Region III',
        ),
        _buildRequestItem(
          requestNo: '5022',
          address: '87 Lake Road, Nevada City',
          region: 'Region I',
        ),
      ],
    );
  }

  Widget _buildRequestItem({
    required String requestNo,
    required String address,
    required String region,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request #$requestNo',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              Text(
                'Pending',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFF97316),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            region,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined, size: 14),
                  label: Text(
                    'Call',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: const Color(0xFF374151),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check, size: 14),
                  label: Text(
                    'Accept',
                    style: GoogleFonts.roboto(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B9AF5),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFilter = text;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF1B9AF5) : Colors.white,
        foregroundColor: isSelected ? Colors.white : const Color(0xFF4B5563),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        side: BorderSide(
          color: isSelected ? Colors.transparent : const Color(0xFFE5E7EB),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 14),
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
          _buildNavItem(0, Icons.home_outlined, 'Home'),
          const Spacer(),
          _buildNavItem(1, Icons.person_outline, 'Profile'),
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