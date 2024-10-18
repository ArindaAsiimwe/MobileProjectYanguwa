import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedIndex = 2; // Booking index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation functionality if needed here
    // For example, navigate to different screens based on index.
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Make the screen scrollable
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,  // 4% of screen width for horizontal padding
              vertical: screenHeight * 0.01,  // 1% of screen height for vertical padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.06,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text("Service Provider: Provider Name",
                    style: TextStyle(fontSize: screenWidth * 0.045)),
                SizedBox(height: screenHeight * 0.025),
                Text("Category: House Cleaning",
                    style: TextStyle(fontSize: screenWidth * 0.045)),
                SizedBox(height: screenHeight * 0.025),
                Text("Date & Time: March 15, 3:00 PM",
                    style: TextStyle(fontSize: screenWidth * 0.045)),
                SizedBox(height: screenHeight * 0.04),

                Text(
                  "Select Date & Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Start: Tue, Oct 24",
                        style: TextStyle(fontSize: screenWidth * 0.045)),
                    Text("End: Wed, Oct 25",
                        style: TextStyle(fontSize: screenWidth * 0.045)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateTimePicker(context, "Select Time"),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),

                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,  // Increased font size
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                _buildDropdown("Select Payment Method"),
                SizedBox(height: screenHeight * 0.04),  // Increased spacing

                Text(
                  "Total Cost",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,  // Increased font size
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text("Service Cost: \$30",
                    style: TextStyle(fontSize: screenWidth * 0.045)),
                SizedBox(height: screenHeight * 0.015),
                Text("Taxes: \$5",
                    style: TextStyle(fontSize: screenWidth * 0.045)),
                SizedBox(height: screenHeight * 0.015),
                Text("Total: \$35",
                    style: TextStyle(fontSize: screenWidth * 0.045)),
                SizedBox(height: screenHeight * 0.04),

                // Full-width Confirm Booking Button
                ElevatedButton(
                  onPressed: () {
                    // Add confirm action here
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, screenHeight * 0.07),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Confirm Booking",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ),
              ],
            ),
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

  Widget _buildDateTimePicker(BuildContext context, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Implement time picker functionality here
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF1F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFFA09CAB),
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF1F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          onChanged: (newValue) {
            // Handle selection
          },
          items: const [
            DropdownMenuItem<String>(
              value: "method1",
              child: Text("Credit Card"),
            ),
            DropdownMenuItem<String>(
              value: "method2",
              child: Text("PayPal"),
            ),
          ],
          hint: Text(
            label,
            style: TextStyle(
              color: const Color(0xFFA09CAB),
              fontSize: MediaQuery.of(context).size.width * 0.045,
            ),
          ),
        ),
      ),
    );
  }
}
