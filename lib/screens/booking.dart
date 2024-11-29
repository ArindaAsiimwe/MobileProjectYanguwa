import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yanguwa_app/screens/home_screen.dart';
import 'package:yanguwa_app/screens/services.dart';
import 'package:yanguwa_app/screens/profile.dart';
import 'package:yanguwa_app/screens/bookings.dart';
import 'package:get/get.dart';
import 'package:yanguwa_app/authentication/controller/auth_controller.dart';

import '../stripe_payments/stripe_service.dart';

class BookingScreen extends StatefulWidget {
  final String serviceName;
  final String providerName;
  final String providerRate;
  final int serviceId;
  final int serviceProviderId;

  const BookingScreen({
    super.key,
    required this.serviceName,
    required this.providerName,
    required this.providerRate,
    required this.serviceId,
    required this.serviceProviderId,
  });

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _selectedPaymentMethod = 'Cash';
  DateTime _selectedDateTime = DateTime.now();
  bool _paymentSuccess = false; // To track if the payment was successful

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();
    final double providerRate = double.tryParse(widget.providerRate) ?? 0.0;
    final double taxes = 0.1 * providerRate;
    final double totalCost = providerRate + taxes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking Info",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                      userName: authenticationController.userName.value)),
            );
          },
        ),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Booking Summary",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow("Service Provider:", widget.providerName),
                _buildInfoRow("Service:", widget.serviceName),
                _buildInfoRow("Rate:", widget.providerRate),
                const SizedBox(height: 16),
                const Text(
                  "Select Date & Time",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDateTime(context),
                  child: _buildInfoRow("Date & Time:",
                      "${_selectedDateTime.toLocal()}".split('.')[0]),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDropdown(context),
                const SizedBox(height: 16),
                const Text(
                  "Total Cost",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow("Service Cost:", providerRate.toString()),
                _buildInfoRow("Taxes:", taxes.toString()),
                _buildInfoRow("Total:", totalCost.toString()),
                const SizedBox(height: 16),

                // Add the payment button for Credit Card
                if (_selectedPaymentMethod == 'Credit/Debit Card')
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _paymentSuccess
                            ? null
                            : () async {
                          int amountInSmallestUnit = (totalCost).toInt();
                          try {
                            bool paymentSuccessful = await StripeService
                                .instance
                                .makePayment(amountInSmallestUnit);

                            if (!paymentSuccessful) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Payment failed. Please try again.'),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                              );
                              return; // Exit if payment fails
                            }
                            setState(() {
                              _paymentSuccess = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'Payment successful. You can confirm your booking now!'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('An error occurred: $e'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A237E),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Make Payment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                // The Confirm Booking button
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (_selectedPaymentMethod == 'Cash' ||
                          (_selectedPaymentMethod == 'Credit/Debit Card' && _paymentSuccess))
                          ? () async {
                        final bookingData = {
                          'user_id': 7, // Replace with actual user ID
                          'service_id': widget.serviceId,
                          'service_provider_id': widget.serviceProviderId,
                          'booking_time':
                          _selectedDateTime.toIso8601String(),
                          'status': 'pending',
                        };

                        final response = await http.post(
                          Uri.parse(
                              'https://yanguwa.edwincodes.tech/api/bookings'),
                          headers: {'Content-Type': 'application/json'},
                          body: json.encode(bookingData),
                        );

                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Booking created successfully'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingsScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                              const Text('Failed to create booking'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      }
                          : null, // Disable if payment is not successful
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A237E),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Confirm Booking",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(color: Color(0xFF1A237E)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home, 'Home', false,
                HomeScreen(userName: authenticationController.userName.value)),
            _buildNavItem(context, Icons.work, 'Services', false, Services()),
            _buildNavItem(
                context, Icons.book, 'Bookings', false, BookingsScreen()),
            _buildNavItem(
                context, Icons.person, 'Profile', false, ProfileScreen()),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: now,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _createBooking(BuildContext context) async {
    final bookingData = {
      'user_id': 7, // Replace with actual user ID
      'service_id': widget.serviceId,
      'service_provider_id': widget.serviceProviderId,
      'booking_time': _selectedDateTime.toIso8601String(),
      'status': 'pending',
    };

    final response = await http.post(
      Uri.parse('https://yanguwa.edwincodes.tech/api/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookingData),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking created successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BookingsScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create booking'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Widget _buildDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedPaymentMethod,
      onChanged: (String? newValue) {
        setState(() {
          _selectedPaymentMethod = newValue!;
        });
      },
      items: <String>['Cash', 'Credit/Debit Card', 'Mobile Money']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: const Color(0xFFEFF1F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF1A237E),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      dropdownColor: Colors.white,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A237E),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A237E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label,
      bool isActive, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.amber : Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.amber : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}