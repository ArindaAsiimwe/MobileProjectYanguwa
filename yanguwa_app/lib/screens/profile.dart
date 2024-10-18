import 'package:flutter/material.dart';

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
        //backgroundColor: Color(0xFFA09CAB),
        title: const Text("Profile Page",
          style: TextStyle(fontSize: 30,
        ),),
        leading: const Icon(Icons.person_2_rounded, color: Color(0xFFA09CAB),),
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
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
        ),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.work, 'Services', 1),
            _buildNavItem(Icons.book, 'Bookings', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }


  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? const Color(0xFF1C1B1F)
                : const Color(0xFFA09CAB),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index
                  ? const Color(0xFF1C1B1F)
                  : const Color(0xFFA09CAB),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

}
