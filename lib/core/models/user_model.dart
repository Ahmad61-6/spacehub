import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String? bio;
  final String? dob;
  final String? address;
  final String? phone;
  final String? profilePhoto;
  final List<Map<String, dynamic>>? bookings;
  final String? createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.bio,
    this.dob,
    this.address,
    this.phone,
    this.profilePhoto,
    this.bookings,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    // Helper function to handle various timestamp formats
    String? parseTimestamp(dynamic timestamp) {
      if (timestamp == null) return null;
      if (timestamp is Timestamp) {
        return timestamp.toDate().toIso8601String();
      }
      if (timestamp is DateTime) {
        return timestamp.toIso8601String();
      }
      if (timestamp is String) {
        return timestamp;
      }
      return null;
    }

    // Helper function to handle bookings data
    List<Map<String, dynamic>>? parseBookings(dynamic bookingsData) {
      if (bookingsData == null) return null;
      if (bookingsData is List) {
        return bookingsData
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }
      return null;
    }

    return UserModel(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      bio: data['bio'],
      dob: data['dob'],
      address: data['address'],
      phone: data['phone'],
      profilePhoto: data['profilePhoto'],
      bookings: parseBookings(data['bookings']),
      createdAt: parseTimestamp(data['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'dob': dob,
      'address': address,
      'phone': phone,
      'profilePhoto': profilePhoto,
      'bookings': bookings,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? bio,
    String? dob,
    String? address,
    String? phone,
    String? profilePhoto,
    List<Map<String, dynamic>>? bookings,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      bookings: bookings ?? this.bookings,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, bio: $bio, dob: $dob, address: $address, phone: $phone, profilePhoto: $profilePhoto, bookings: $bookings, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          bio == other.bio &&
          dob == other.dob &&
          address == other.address &&
          phone == other.phone &&
          profilePhoto == other.profilePhoto &&
          bookings == other.bookings &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      bio.hashCode ^
      dob.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      profilePhoto.hashCode ^
      bookings.hashCode ^
      createdAt.hashCode;
}
