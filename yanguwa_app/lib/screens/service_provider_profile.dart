import 'package:flutter/material.dart';

class ServiceProviderProfile extends StatelessWidget {
  const ServiceProviderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,

            children: [

              Container(
                height: 200, // Set the height of the image holder
                width: double.infinity,
                decoration:  const BoxDecoration(
                  color: Color(0xFF31D0D0), // Background color for the image holder
                  image: DecorationImage(
                    image: NetworkImage('https://res.cloudinary.com/dbibjvyhm/image/upload/v1722850860/Screenshot_2024-07-29_at_13.50.39_acat73.png'), // Replace with your image path
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

              const SizedBox(height: 16), // Adds some spacing after the image holder

              Container(
                child: Column(
                  children: [
                    _getProviderName("Dry Masters"),
                    Row(
                       children: [

                         _getRatings(4.99, 455, " This is the bio")  // Pass actual numbers and bio text
                       ],
                    )

                  ],
                ),
              ),

              Container(
                child: Row(
                  children: [
                    _StartandEndDates(Text("Tues, Oct 24"), Text("Wed, Oct 25")),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              _bookAction(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child:  ListTile(
                  title: Text("Reviews",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: _getReviews(1),
                ),
              ),

              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                // decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.pages_rounded, 'Provider Profile', true),
                    _buildNavItem(Icons.work, 'Services', false),
                    _buildNavItem(Icons.book, 'Bookings', false),
                    _buildNavItem(Icons.person, 'Profile', false),
                  ],
                ),
              ),
            ],



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
          style: TextStyle(
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

Widget _getReviews(id){
  return ListTile(

    title: Text('User $id',style: TextStyle(fontWeight: FontWeight.bold),),
    subtitle: Text("Great Service Looking to using again."),



  );
}


Widget _getRatings(double ratingCount, int reviewsCount, String bio){

  return Padding(
    padding: const EdgeInsets.all(16.0), // Adjust margin as needed
    child: Column(
      children: [
        Row(
        children: [
        Icon(Icons.star_rate_outlined,color: Colors.indigo),

        Text("$ratingCount", style: TextStyle(fontWeight: FontWeight.w900),),
          SizedBox(width: 30),
        Text(" $reviewsCount reviews", style: TextStyle(fontWeight: FontWeight.w300)),
      ]

    ),
  Text(bio,style: TextStyle(fontSize: 22),),
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
            Text("Start", style: TextStyle(fontWeight: FontWeight.w300)),
            Text(
              start.data ?? '', // Safely access the text from the 'end' widget
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // For example, styling the 'end' date in red
              ),
            ),  // Display the start date passed as Text widget
          ],
        ),
        const SizedBox(width: 90),

        // Label for end date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("End", style: TextStyle(fontWeight: FontWeight.w300)),
            Text(
              end.data ?? '', // Safely access the text from the 'end' widget
              style: TextStyle(
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

Widget _bookAction() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0), // Adds padding to the left and right
    child: SizedBox(
      width: double.infinity, // Ensures the button fits the available width minus the padding
      child: ElevatedButton(
        onPressed: () {
          // Add your button's onPressed logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 12), // Vertical padding for button height
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

