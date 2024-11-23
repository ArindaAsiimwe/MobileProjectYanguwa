// import 'package:flutter/material.dart';
// import 'package:yanguwa_app/screens/booking.dart';
// import 'package:yanguwa_app/screens/service_provider_profile.dart';
//
// import '../screens/home_screen.dart';
// import '../screens/profile.dart';
//
// class BottomNavBarScreen extends StatefulWidget {
//   const BottomNavBarScreen({super.key});
//
//   @override
//   _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
// }
//
// class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const ServiceProviderProfile(),
//     const BookingScreen(),
//     const ProfileScreen(),
//
//     // Add more screens here
//     // Container(color: Colors.blue),
//     // Container(color: Colors.green),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: _screens[_currentIndex],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         selectedItemColor: const Color(0xFF1C1B1F),
//         unselectedItemColor: const Color(0xFFA09CAB),
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: "Services",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: "Bookings",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }
