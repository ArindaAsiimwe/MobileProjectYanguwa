class Service {
  final int id;
  final String title;
  final String description;
  final int price;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      title: json['name'] ?? 'N/A',
      description: json['description'] ?? 'N/A',
      price: json['price'] ?? 0, // Provide a default value for price
    );
  }
}