import 'package:flutter/material.dart';
import 'package:yanguwa_app/screens/booking.dart';
import 'package:yanguwa_app/screens/services.dart';

import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Profile index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation functionality here
    // For example, navigate to different screens based on index.
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,  // 5% of screen width padding
            vertical: screenHeight * 0.03,   // 3% of screen height padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth,
                height: 250,
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/profile.png"),
                    fit: BoxFit.cover
                  )
                ),
              ),
              // User Info
              Text(
                "User Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.07,  // Adjusted font size
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "useremail@example.com",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,  // Adjusted font size for email
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Booking History
              Text(
                "Booking History",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,  // Adjusted font size
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Upcoming Booking
              Text(
                "Upcoming Booking with Provider A",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,  // Adjusted font size
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                "March 15, 3:00 PM",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,  // Smaller font for date/time
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Past Booking
              Text(
                "Past Booking with Provider B",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,  // Adjusted font size
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                "February 10, 11:00 AM",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,  // Smaller font for date/time
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Payment Methods
              Text(
                "Payment Methods",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,  // Adjusted font size
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Existing Card
              Text(
                "Visa **** **** **** 1234",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,  // Adjusted font size
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                "Add new payment method",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,  // Adjusted font size
                  color: Colors.blue,  // Link-style color
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Account Settings
              Text(
                "Account Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,  // Adjusted font size
                ),
              ),
            ],
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
            _buildNavItem(context, Icons.book, 'Bookings', false, BookingScreen()),
            _buildNavItem(context, Icons.person, 'Profile', true, ProfileScreen()),
          ],
        ),
      ),
    );
  }


  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isActive, Widget page) {
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
