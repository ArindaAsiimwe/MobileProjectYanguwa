import 'package:flutter/material.dart';
import 'package:yanguwa_app/screens/bookings.dart';
import 'package:yanguwa_app/screens/profile.dart';
import 'package:yanguwa_app/screens/services.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yanguwa",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1A237E),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header with search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back, $userName',
                    style: TextStyle(
                      color: Color(0xFF1C1B1F),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF1F5),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Color(0xFFA09CAB)),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for services (e.g., cleaning, petcare)',
                              hintStyle: TextStyle(
                                color: Color(0xFFA09CAB),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Featured Services Section (Horizontal Slider)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Featured Services',
                style: TextStyle(
                  color: Color(0xFF1C1B1F),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Horizontal slider for Featured Services
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildServiceCard('House Cleaning', 'Fast & Reliable', Icons.cleaning_services),
                  _buildServiceCard('Childcare', 'Safe & Trustworthy', Icons.child_care),
                  _buildServiceCard('Repair', 'Quick Assistance', Icons.local_shipping),
                  _buildServiceCard('Pet Care', 'Loving & Attentive', Icons.pets),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Categories Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  //color: Color
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Categories List
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5, // Adjust as needed for card aspect ratio
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildCategoryCard('House Cleaning', Icons.cleaning_services),
                  _buildCategoryCard('Childcare', Icons.child_care),
                  _buildCategoryCard('Errand Running', Icons.local_shipping),
                  _buildCategoryCard('Pet Care', Icons.pets),
                  _buildCategoryCard('Eldercare', Icons.elderly),
                  _buildCategoryCard('Tutoring', Icons.school),
                ],
              ),
            ),

            // Bottom Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(color: Color(0xFF1A237E)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, Icons.home, 'Home', true, HomeScreen(userName: userName)),
                  _buildNavItem(context, Icons.work, 'Services', false, Services()),
                  _buildNavItem(context, Icons.book, 'Bookings', false, BookingsScreen()),
                  _buildNavItem(context, Icons.person, 'Profile', false, ProfileScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a Featured Service Card (used in the horizontal slider)
  Widget _buildServiceCard(String title, String subtitle, IconData icon) {
    return Container(
      width: 140, // Reduced width for horizontal scrolling items
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white, // Updated color for featured services
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Icon(icon, size: 36, color: Colors.amberAccent), // Reduced icon size for service
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1A237E),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFFA09CAB),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Function to build a Category Card (used in the grid of categories)
  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 1.5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Icon(icon, size: 36, color: Color(0xFF1A237E)),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFA09CAB),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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