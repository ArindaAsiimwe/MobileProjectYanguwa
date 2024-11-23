class ServiceProvider {
  final String name;
  final String email;
  final String phone;
  final String bio;
  final double ratingCount = 2;
  final int reviewsCount= 5;

  ServiceProvider({required this.name, required this.email,
  required this.phone, required this.bio});

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      bio: json['bio']
    );
  }
}