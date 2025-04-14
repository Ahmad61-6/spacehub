import 'package:cloud_firestore/cloud_firestore.dart';

class Workspace {
  final String? id;
  final String name;
  final String category; // 'private', 'office', 'space'
  final double rating;
  final int reviews;
  final GeoPoint location;
  final String locationName;
  final List<String> facilities;
  final double price;
  final List<String> imageUrls;
  final String? description;
  final DateTime createdAt;

  Workspace({
    this.id,
    required this.name,
    required this.category,
    this.rating = 0.0,
    this.reviews = 0,
    required this.location,
    required this.locationName,
    required this.facilities,
    required this.price,
    required this.imageUrls,
    this.description,
    required this.createdAt,
  });

  factory Workspace.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Workspace(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? 'private',
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviews: (data['reviews'] ?? 0).toInt(),
      location: data['location'] ?? const GeoPoint(0, 0),
      locationName: data['locationName'] ?? '',
      facilities: List<String>.from(data['facilities'] ?? []),
      price: (data['price'] ?? 0.0).toDouble(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      description: data['description'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'rating': rating,
      'reviews': reviews,
      'location': location,
      'locationName': locationName,
      'facilities': facilities,
      'price': price,
      'imageUrls': imageUrls,
      if (description != null) 'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Workspace copyWith({
    String? id,
    String? name,
    String? category,
    String? primaryImage,
    double? rating,
    int? reviews,
    GeoPoint? location,
    String? locationName,
    List<String>? facilities,
    double? price,
    List<String>? imageUrls,
    String? description,
    DateTime? createdAt,
  }) {
    return Workspace(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      location: location ?? this.location,
      locationName: locationName ?? this.locationName,
      facilities: facilities ?? this.facilities,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
