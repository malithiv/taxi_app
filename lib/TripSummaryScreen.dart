import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CustomerHomeScreen.dart';

class TripSummaryScreen extends StatefulWidget {
  const TripSummaryScreen({Key? key}) : super(key: key);

  @override
  State<TripSummaryScreen> createState() => _TripSummaryScreenState();
}

class _TripSummaryScreenState extends State<TripSummaryScreen> {
  final _distanceController = TextEditingController();
  final _baseAmountController = TextEditingController();
  double _totalAmount = 0.0;
  double _additionalAmount = 0.0;

  void _calculateTotal() {
    final baseAmount = double.tryParse(_baseAmountController.text) ?? 0.0;
    final additional = baseAmount * 0.10; // 10% additional
    setState(() {
      _additionalAmount = additional;
      _totalAmount = baseAmount + additional;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF023047),
              ),
              child: Text(
                'Trip Summary',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Trip Details'),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Distance (km)',
                      controller: _distanceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Base Amount (\$)',
                      controller: _baseAmountController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _calculateTotal(),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Calculation Summary'),
                    const SizedBox(height: 16),
                    _buildCalculationRow('Base Amount:', _baseAmountController.text.isEmpty ? '0.00' : _baseAmountController.text),
                    const SizedBox(height: 8),
                    _buildCalculationRow('Additional (10%):', _additionalAmount.toStringAsFixed(2)),
                    const SizedBox(height: 16),
                    Container(
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
                      child: _buildCalculationRow(
                        'Total Amount:',
                        _totalAmount.toStringAsFixed(2),
                        isTotal: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to CustomerHomeScreen and remove all previous routes
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const CustomerHomeScreen(),
                    ),
                        (route) => false, // This removes all previous routes from the stack
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Submit Trip Details',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    void Function(String)? onChanged,
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
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Enter ${label.toLowerCase()}',
              hintStyle: GoogleFonts.roboto(
                color: const Color(0xFF9CA3AF),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Text(
              '\$',
              style: GoogleFonts.roboto(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              amount,
              style: GoogleFonts.roboto(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}