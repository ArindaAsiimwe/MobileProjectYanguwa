import 'package:flutter/material.dart';
import 'package:yanguwa_app/authentication/model/service.dart';
import 'package:yanguwa_app/screens/home_screen.dart';
import 'package:yanguwa_app/screens/services.dart';
import 'package:yanguwa_app/screens/profile.dart';
import '../authentication/model/booking_model.dart';
import '../authentication/service/api_service.dart';
import '../stripe_payments/stripe_service.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _selectedPaymentMethod = 'Credit Card';
  // Future<Booking>? _Booking;

  // Future<List<Service>>? _services;

  // @override
  // void initState() {
  //   super.initState();
  //   _services = fetchServices();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking",
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
              MaterialPageRoute(builder: (context) => Services()),
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
                _buildInfoRow("Service Provider:", "Provider Name"),
                _buildInfoRow("Category:", "House Cleaning"),
                _buildInfoRow("Date & Time:", "March 15, 3:00 PM"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateTimePicker(context, "Start: Tue, Oct 24"),
                    _buildDateTimePicker(context, "End: Wed, Oct 25"),
                  ],
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
                _buildInfoRow("Service Cost:", "\$30"),
                _buildInfoRow("Taxes:", "\$5"),
                _buildInfoRow("Total:", "\$35"),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Add confirm action here
                        await StripeService.instance.makePayment();

                        // Booking booking = Booking(
                        //   serviceId: 1,
                        //   serviceProviderId: 1,
                        //   bookingTime: "$startDate - $endDate",
                        //   status: 'Pending',
                        // );

                        // try{
                        //   // Perform payment
                        //   //bool paymentSuccess = true;
                        //   //await StripeService.instance.makePayment();
                        // } catch (e) {
                        //   // Handle exceptions
                        //   print('Error during payment or booking: $e');
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text('An error occurred: $e'),
                        //     ),
                        //   );
                        // }
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
            _buildNavItem(context, Icons.home, 'Home', false, HomeScreen()),
            _buildNavItem(context, Icons.work, 'Services', false, Services()),
            _buildNavItem(
                context, Icons.book, 'Bookings', true, BookingScreen()),
            _buildNavItem(
                context, Icons.person, 'Profile', false, ProfileScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedPaymentMethod,
      onChanged: (String? newValue) {
        setState(() {
          _selectedPaymentMethod = newValue!;
        });
      },
      items: <String>['Credit Card', 'Mobile Money']
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

  Widget _buildDateTimePicker(BuildContext context, String label) {
    // Implement your date time picker here
    return Text(label);
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
