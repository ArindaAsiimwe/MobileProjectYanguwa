import 'package:flutter/material.dart';
import 'package:yanguwa_app/screens/service_provider_profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    'Yanguwa',
                    style: TextStyle(
                      color: Color(0xFF1C1B1F),
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFEFF1F5),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Color(0xFFA09CAB)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for services (e.g., cleaning, childcare)',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
              height: 180, // Reduced height for the slider
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [

                  _buildServiceCard('House Cleaning', 'Fast & Reliable', Icons.cleaning_services),
                  _buildServiceCard('Childcare', 'Safe & Trustworthy', Icons.child_care),
                  _buildServiceCard('Errand Running', 'Quick Assistance', Icons.local_shipping),
                  _buildServiceCard('Pet Care', 'Loving & Attentive', Icons.pets),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Color(0xFF1C1B1F),
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
                  //_buildCategoryCard('House Cleaning', Icons.cleaning_services),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServiceProviderProfile()),
                      );
                    },
                    child: _buildCategoryCard('House Cleaning', Icons.cleaning_services),
                  ),
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
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', true),
                  _buildNavItem(Icons.work, 'Services', false),
                  _buildNavItem(Icons.book, 'Bookings', false),
                  _buildNavItem(Icons.person, 'Profile', false),
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
        color: Color(0xFFEFF1F5), // Updated color for featured services
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Icon(icon, size: 36, color: Color(0xFFA09CAB)), // Reduced icon size for service
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF1C1B1F),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
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
        color: Color(0xFFEFF1F5), // Updated color for category cards
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Icon(icon, size: 36, color: Color(0xFFA09CAB)), // Reduced icon size for category
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF1C1B1F),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

}

// Function to build a navigation item
Widget _buildNavItem(IconData icon, String label, bool isActive) {
  return Column(
    children: [
      Icon(icon, color: isActive ? Color(0xFF1C1B1F) : Color(0xFFA09CAB)),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          color: isActive ? Color(0xFF1C1B1F) : Color(0xFFA09CAB),
          fontSize: 12,
        ),
      ),
    ],
  );
}
