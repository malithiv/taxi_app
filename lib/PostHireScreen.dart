import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostHireScreen extends StatefulWidget {
  const PostHireScreen({Key? key}) : super(key: key);

  @override
  State<PostHireScreen> createState() => _PostHireScreenState();
}

class _PostHireScreenState extends State<PostHireScreen> {
  bool agreeToTerms = false;
  bool isRoundTrip = false;
  final TextEditingController _phone1Controller = TextEditingController();
  final TextEditingController _phone2Controller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pickupLocationController = TextEditingController();
  final TextEditingController _stopLocationController = TextEditingController();
  final TextEditingController _dropoffLocationController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _passengersController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  final TextEditingController _returnTimeController = TextEditingController();
  DateTime? returnDate;
  TimeOfDay? returnTime;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    _descriptionController.dispose();
    _pickupLocationController.dispose();
    _stopLocationController.dispose();
    _dropoffLocationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _vehicleTypeController.dispose();
    _passengersController.dispose();
    super.dispose();
  }



// Update the date picker method
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

// Update the time picker method
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

// Update the return date picker method
  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: returnDate ?? (selectedDate?.add(const Duration(days: 1)) ?? DateTime.now()),
      firstDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != returnDate) {
      setState(() {
        returnDate = picked;
        _returnDateController.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

// Update the return time picker method
  Future<void> _selectReturnTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: returnTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != returnTime) {
      setState(() {
        returnTime = picked;
        _returnTimeController.text = picked.format(context);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildTripDetailsCard(),
              const SizedBox(height: 16),
              _buildDescriptionCard(),
              const SizedBox(height: 16),
              _buildContactInfoCard(),
              const SizedBox(height: 16),
              _buildImportantNotice(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlue,
      elevation: 2,
      title: Text(
        'Post New Hire',
        style: GoogleFonts.roboto(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildTripDetailsCard() {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Details',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Round Trip',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: const Color(0xFF4B5563),
                  ),
                ),
                const Spacer(),
                Switch(
                  inactiveTrackColor: Colors.white,
                  value: isRoundTrip,
                  onChanged: (value) {
                    setState(() {
                      isRoundTrip = value;
                    });
                  },
                  activeColor: Colors.lightBlue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _pickupLocationController,
              label: 'Pickup Location',
              icon: Icons.location_on_outlined,
            ),
            if (isRoundTrip) ...[
              const SizedBox(height: 16),
              _buildTextField(
                controller: _stopLocationController,
                label: 'Stop Location',
                icon: Icons.add_location_alt_outlined,
              ),
            ],
            const SizedBox(height: 16),
            _buildTextField(
              controller: _dropoffLocationController,
              label: 'Drop-off Location',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 16),
            // In the _buildTripDetailsCard method, replace the date/time Row with:
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: _buildTextField(
                      controller: _dateController,
                      label: 'Date',
                      icon: Icons.calendar_today_outlined,
                      readOnly: true, // Make it read-only
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: _buildTextField(
                      controller: _timeController,
                      label: 'Time',
                      icon: Icons.access_time,
                      readOnly: true, // Make it read-only
                    ),
                  ),
                ),
              ],
            ),
            if (isRoundTrip) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectReturnDate(context),
                      child: _buildTextField(
                        controller: _returnDateController,
                        label: 'Return Date',
                        icon: Icons.calendar_today_outlined,
                        readOnly: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectReturnTime(context),
                      child: _buildTextField(
                        controller: _returnTimeController,
                        label: 'Return Time',
                        icon: Icons.access_time,
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _vehicleTypeController,
                    label: 'Vehicle Type',
                    icon: Icons.directions_car_outlined,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _passengersController,
                    label: 'Passengers',
                    icon: Icons.person_outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF6B7280)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phone1Controller,
              keyboardType: TextInputType.phone,
              decoration: _buildPhoneInputDecoration('Primary Phone Number'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phone2Controller,
              keyboardType: TextInputType.phone,
              decoration: _buildPhoneInputDecoration('Alternative Phone Number (Optional)'),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildPhoneInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.roboto(
        fontSize: 14,
        color: const Color(0xFF6B7280),
      ),
      prefixIcon: const Icon(
        Icons.phone_outlined,
        size: 18,
        color: Color(0xFF6B7280),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF6B7280)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF6B7280)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.lightBlue),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }



  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
  }) {
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
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6B7280)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6B7280)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.lightBlue),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFCE8),
        border: Border.all(color: const Color(0xFFFEF08A)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 14,
            color: Color(0xFF111827),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important Notice',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Please only confirm the hire if you can pick up customers ON TIME. Drivers who accept trips and fail to show up without valid reason will be permanently blocked from future bookings.',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE5E7EB),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
                activeColor: Colors.lightBlue,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'I agree to provide required documentation and understand the terms of service',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                if (!agreeToTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please accept the terms and conditions'),
                    ),
                  );
                  return;
                }
                Navigator.pushNamed(context, '/myhires');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Post Hire',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}