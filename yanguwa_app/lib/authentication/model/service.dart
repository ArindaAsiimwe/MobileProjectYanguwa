class Service {
  final String title;
  final String description;

  Service({required this.title, required this.description});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      title: json['name'],
      description: json['description'],
    );
  }
}