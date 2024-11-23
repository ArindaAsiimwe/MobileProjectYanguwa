import 'package:flutter/material.dart';
import 'package:yanguwa_app/screens/booking.dart';
import 'package:yanguwa_app/screens/home_screen.dart';
import 'package:yanguwa_app/screens/profile.dart';
import 'package:yanguwa_app/screens/services.dart';

class ServiceProviderProfile extends StatelessWidget {
  const ServiceProviderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Service Provider Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF1A237E),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200, // Set the height of the image holder
              width: double.infinity,
              decoration: const BoxDecoration(
                color:
                    Color(0xFF31D0D0), // Background color for the image holder
                image: DecorationImage(
                  image: NetworkImage(
                      'https://res.cloudinary.com/dbibjvyhm/image/upload/v1722850860/Screenshot_2024-07-29_at_13.50.39_acat73.png'), // Replace with your image path
                  fit: BoxFit.cover, // This makes the image cover the container
                ),
              ),
              child: const Center(
                child: Text(
                  'Service Provider Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getProviderName("Dry Masters"),
                  Row(
                    children: [
                      _getRatings(4.99, 455, " This is the bio"),
                    ],
                  ),
                  _StartandEndDates(
                      const Text("Tues, Oct 24"), const Text("Wed, Oct 25")),
                  const SizedBox(height: 16),
                  _bookAction(context),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text(
                      "Reviews",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: _getReviews(1),
                  ),
                ],
              ),
            ),
          ],
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
                context, Icons.book, 'Bookings', false, BookingScreen()),
            _buildNavItem(
                context, Icons.person, 'Profile', false, ProfileScreen()),
          ],
        ),
      ),
    );
  }
}

Widget _getProviderName(String name) {
  return Padding(
    padding: const EdgeInsets.all(16.0), // Adjust margin as needed
    child: Row(
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF1C1B1F),
            fontSize: 50,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  );
}

Widget _getReviews(id) {
  return ListTile(
    title: Text(
      'User $id',
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: const Text("Great Service Looking to using again."),
  );
}

Widget _getRatings(double ratingCount, int reviewsCount, String bio) {
  return Padding(
    padding: const EdgeInsets.all(16.0), // Adjust margin as needed
    child: Column(
      children: [
        Row(children: [
          const Icon(Icons.star_rate_outlined, color: Colors.indigo),
          Text(
            "$ratingCount",
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(width: 30),
          Text(" $reviewsCount reviews",
              style: const TextStyle(fontWeight: FontWeight.w300)),
        ]),
        Text(
          bio,
          style: const TextStyle(fontSize: 22),
        ),
      ],
    ),
  );
}

Widget _StartandEndDates(Text start, Text end) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Label for start date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Start", style: TextStyle(fontWeight: FontWeight.w300)),
            Text(
              start.data ?? '', // Safely access the text from the 'end' widget
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // For example, styling the 'end' date in red
              ),
            ), // Display the start date passed as Text widget
          ],
        ),
        const SizedBox(width: 90),

        // Label for end date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("End", style: TextStyle(fontWeight: FontWeight.w300)),
            Text(
              end.data ?? '', // Safely access the text from the 'end' widget
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _bookAction(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 24.0), // Adds padding to the left and right
    child: SizedBox(
      width: double
          .infinity, // Ensures the button fits the available width minus the padding
      child: ElevatedButton(
        onPressed: () {
          // Add your button's onPressed logic here

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1A237E),
          padding: const EdgeInsets.symmetric(
              vertical: 12), // Vertical padding for button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
        ),
        child: const Text(
          'Book Now', // Text inside the button
          style: TextStyle(
            color: Colors.white, // Text color (white)
            fontSize: 16, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
      ),
    ),
  );
}

// Function to build a navigation item
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




//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:yanguwa_app/stripe_payments/stripe_service.dart';
//
// import '../authentication/model/service_provider.dart';
//
// class ServiceProviderProfile extends StatelessWidget {
//   const ServiceProviderProfile({super.key});
//
//   Future<List<ServiceProvider>> fetchServiceProviders() async {
//     final response = await http.get(
//       Uri.parse('https://yanguwa.edwincodes.tech/admin/service-providers'),
//     );
//
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((serviceProvider) => ServiceProvider.fromJson(serviceProvider))
//           .toList();
//     } else {
//       throw Exception('Failed to load service providers');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Service Provider Profile",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.keyboard_arrow_left,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: const Color(0xFF1A237E),
//       ),
//       backgroundColor: Colors.white,
//       body: FutureBuilder<List<ServiceProvider>>(
//         future: fetchServiceProviders(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No service providers available'));
//           } else {
//             final serviceProvider = snapshot.data!.first; // Using the first item
//
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF31D0D0),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           'https://res.cloudinary.com/dbibjvyhm/image/upload/v1722850860/Screenshot_2024-07-29_at_13.50.39_acat73.png',
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Service Provider Image',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _getProviderName(serviceProvider.name),
//                         Row(
//                           children: [
//                             _getRatings(
//                               serviceProvider.ratingCount,
//                               serviceProvider.reviewsCount,
//                               serviceProvider.bio,
//                             ),
//                           ],
//                         ),
//                         _StartandEndDates(
//                           const Text("Tues, Oct 24"),
//                           const Text("Wed, Oct 25"),
//                         ),
//                         const SizedBox(height: 16),
//                         _bookAction(),
//                         const SizedBox(height: 16),
//                         ListTile(
//                           title: const Text(
//                             "Reviews",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: _getReviews(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// Widget _getProviderName(String name) {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Row(
//       children: [
//         Text(
//           name,
//           style: const TextStyle(
//             color: Color(0xFF1C1B1F),
//             fontSize: 50,
//             fontWeight: FontWeight.w600,
//           ),
//           textAlign: TextAlign.left,
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _getReviews() {
//   return ListTile(
//     title: Text(
//       'User ',
//       style: const TextStyle(fontWeight: FontWeight.bold),
//     ),
//     subtitle: const Text("Great Service Looking to using again."),
//   );
// }
//
// Widget _getRatings(double ratingCount, int reviewsCount, String bio) {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       children: [
//         Row(children: [
//           const Icon(Icons.star_rate_outlined, color: Colors.indigo),
//           Text(
//             "$ratingCount",
//             style: const TextStyle(fontWeight: FontWeight.w900),
//           ),
//           const SizedBox(width: 30),
//           Text(" $reviewsCount reviews",
//               style: const TextStyle(fontWeight: FontWeight.w300)),
//         ]),
//         Text(
//           bio,
//           style: const TextStyle(fontSize: 22),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _StartandEndDates(Text start, Text end) {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Start", style: TextStyle(fontWeight: FontWeight.w300)),
//             Text(
//               start.data ?? '',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(width: 90),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("End", style: TextStyle(fontWeight: FontWeight.w300)),
//             Text(
//               end.data ?? '',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _bookAction() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//     child: SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           // Add your button's onPressed logic here
//           StripeService.instance.makePayment();
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF1A237E),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: const Text(
//           'Book Now',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ),
//   );
// }