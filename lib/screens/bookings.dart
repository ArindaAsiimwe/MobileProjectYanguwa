import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yanguwa_app/screens/home_screen.dart';
import 'package:yanguwa_app/screens/services.dart';
import 'package:yanguwa_app/screens/profile.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yanguwa_app/authentication/controller/auth_controller.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingsScreen> {
  late Future<List<dynamic>> _bookings;

  @override
  void initState() {
    super.initState();
    _bookings = fetchBookings();
  }

  Future<List<dynamic>> fetchBookings() async {
    final response = await http
        .get(Uri.parse('https://yanguwa.edwincodes.tech/api/bookings'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookings",
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
              MaterialPageRoute(builder: (context) => HomeScreen(userName: authenticationController.userName.value)),
            );
          },
        ),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings available'));
          } else {
            final bookings = snapshot.data!.reversed.toList();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: bookings.map((booking) {
                    return Container(
                      width: 390, // Set the fixed width here
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Service: ${booking['service']['name']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Provider: ${booking['service_provider']['name']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rate: ${booking['service_provider']['price']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Date: ${booking['booking_time']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Status: ${booking['status']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(color: Color(0xFF1A237E)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home, 'Home', false, HomeScreen(userName: authenticationController.userName.value)),
            _buildNavItem(context, Icons.work, 'Services', false, Services()),
            _buildNavItem(
                context, Icons.book, 'Bookings', true, BookingsScreen()),
            _buildNavItem(
                context, Icons.person, 'Profile', false, ProfileScreen()),
          ],
        ),
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