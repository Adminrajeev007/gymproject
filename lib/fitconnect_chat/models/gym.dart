class Gym {
  final String id;
  final String name;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? image;
  final String? rating;
  final int memberCount;
  final bool isOpen;
  final String? hours;
  final List<String> amenities;
  final DateTime createdAt;

  Gym({
    required this.id,
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
    this.image,
    this.rating,
    required this.memberCount,
    required this.isOpen,
    this.hours,
    required this.amenities,
    required this.createdAt,
  });

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      image: json['image'],
      rating: json['rating'],
      memberCount: json['memberCount'] ?? 0,
      isOpen: json['isOpen'] ?? true,
      hours: json['hours'],
      amenities: List<String>.from(json['amenities'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
      'rating': rating,
      'memberCount': memberCount,
      'isOpen': isOpen,
      'hours': hours,
      'amenities': amenities,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}