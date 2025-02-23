import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildTripsList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF023047),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip History',
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your recent trips and earnings',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList() {
    final trips = [
      {
        'date': '23 Feb 2025',
        'pickup': 'Colombo Fort',
        'dropoff': 'Galle Face Green',
        'amount': '\$12.50',
        'status': 'Completed',
        'time': '10:30 AM',
      },
      {
        'date': '23 Feb 2025',
        'pickup': 'Bambalapitiya',
        'dropoff': 'Kollupitiya',
        'amount': '\$8.75',
        'status': 'Completed',
        'time': '2:15 PM',
      },
      {
        'date': '22 Feb 2025',
        'pickup': 'Wellawatte',
        'dropoff': 'Mount Lavinia',
        'amount': '\$15.20',
        'status': 'Completed',
        'time': '11:45 AM',
      },
      {
        'date': '22 Feb 2025',
        'pickup': 'Dehiwala',
        'dropoff': 'Ratmalana',
        'amount': '\$10.30',
        'status': 'Cancelled',
        'time': '9:20 AM',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return _buildTripCard(trip);
      },
    );
  }

  Widget _buildTripCard(Map<String, String> trip) {
    final isCompleted = trip['status'] == 'Completed';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trip['date']!,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                trip['time']!,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Color(0xFF1B9AF5)),
              const SizedBox(width: 8),
              Text(
                trip['pickup']!,
                style: GoogleFonts.roboto(fontSize: 14),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Container(
              width: 2,
              height: 20,
              color: const Color(0xFFE5E7EB),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Color(0xFF374151)),
              const SizedBox(width: 8),
              Text(
                trip['dropoff']!,
                style: GoogleFonts.roboto(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trip['amount']!,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1B9AF5),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trip['status']!,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: isCompleted
                        ? const Color(0xFF059669)
                        : const Color(0xFFDC2626),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home_outlined, 'Home', false),
          _buildNavItem(context, Icons.history, 'History', true),
          _buildNavItem(context, Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          switch (label) {
            case 'Home':
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 'Profile':
              Navigator.pushReplacementNamed(context, '/profile');
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