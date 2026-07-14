import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String photoUrl;
  final String city;
  final String state;
  final String country;
  final String email;
  final String phone;
  final String gender;

  // Derived deterministic fields
  final int matchPercent; // 50–99
  final int trustPercent; // 50–99
  final String replyTime; // "5m", "1h", "3h", etc.
  final bool isOnline;
  final int distanceKm; // mock 1–30

  // Static mock fields
  final String occupation;
  final String height;
  final String relationshipIntent;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.photoUrl,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.phone,
    required this.gender,
    required this.matchPercent,
    required this.trustPercent,
    required this.replyTime,
    required this.isOnline,
    required this.distanceKm,
    required this.occupation,
    required this.height,
    required this.relationshipIntent,
  });

  String get fullName => '$firstName $lastName';
  String get displayLocation => '$city · $distanceKm km away';

  @override
  List<Object?> get props => [id];
}
