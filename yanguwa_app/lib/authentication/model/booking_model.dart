class Booking {
  final int id;
  final int userId;
  final int serviceId;
  final int serviceProviderId;
  final String bookingTime;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.serviceProviderId,
    required this.bookingTime,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      serviceId: json['service_id'],
      serviceProviderId: json['service_provider_id'],
      bookingTime: json['booking_time'],
      status: json['status'],
    );
  }
}
