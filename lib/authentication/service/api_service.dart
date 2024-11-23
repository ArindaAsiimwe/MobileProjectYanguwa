// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yanguwa_app/authentication/model/service.dart';
import '../model/booking_model.dart';

Future<List<Service>> fetchServices() async {
  final response =
      await http.get(Uri.parse('https://yanguwa.edwincodes.tech/api/services'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((service) => Service.fromJson(service)).toList();
  } else {
    throw Exception('Failed to load services');
  }
}

Future<List<Booking>> fetchBookings() async {
  final response =
      await http.get(Uri.parse('https://yanguwa.edwincodes.tech/api/bookings'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Booking.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load bookings');
  }
}

Future<Booking> createBooking(Booking booking) async {
  final response = await http.post(
    Uri.parse('https://yanguwa.edwincodes.tech/api/bookings'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your-access-token'
    },
    body: json.encode({
      'user_id': booking.userId,
      'service_id': booking.serviceId,
      'service_provider_id': booking.serviceProviderId,
      'booking_time': booking.bookingTime,
      'status': booking.status,
    }),
  );

  if (response.statusCode == 201) {
    print('Booking created successfully');
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    return Booking.fromJson(responseBody);
  } else {
    print('Booking creation failed');
    throw Exception('Failed to create booking');
  }
}
