import '../../domain/entities/user_entity.dart';

/// Static mock data seeded by a reproducible index so values are stable.
const List<String> _occupations = [
  'Content Creator',
  'Software Engineer',
  'Graphic Designer',
  'Doctor',
  'Entrepreneur',
  'Marketing Manager',
  'Photographer',
  'Teacher',
  'Product Manager',
  'Architect',
];

const List<String> _heights = [
  "5'2\"",
  "5'4\"",
  "5'6\"",
  "5'8\"",
  "5'10\"",
  "5'11\"",
  "6'0\"",
  "6'1\"",
  "5'3\"",
  "5'5\"",
];

const List<String> _intents = [
  'Serious relationship',
  'Something casual',
  'Open to anything',
  'Long-term relationship',
  'Friendship first',
  'Marriage minded',
];

const List<String> _replyTimes = [
  '5m',
  '12m',
  '1h',
  '30m',
  '2h',
  '3h',
  '20m',
  '45m',
  '10m',
  '1.5h',
];

class UserModel {
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
  final String loginUuid;

  const UserModel({
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
    required this.loginUuid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, int index) {
    final name = json['name'] as Map<String, dynamic>? ?? {};
    final dob = json['dob'] as Map<String, dynamic>? ?? {};
    final picture = json['picture'] as Map<String, dynamic>? ?? {};
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final login = json['login'] as Map<String, dynamic>? ?? {};

    final uuid = login['uuid'] as String? ?? 'user_$index';

    return UserModel(
      id: uuid,
      firstName: name['first'] as String? ?? 'Unknown',
      lastName: name['last'] as String? ?? '',
      age: (dob['age'] as num?)?.toInt() ?? 25,
      photoUrl: picture['large'] as String? ?? '',
      city: (location['city'] as String?) ?? 'Unknown City',
      state: (location['state'] as String?) ?? '',
      country: (location['country'] as String?) ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      gender: json['gender'] as String? ?? 'other',
      loginUuid: uuid,
    );
  }

  /// Derives deterministic values from the uuid hash so they never change
  /// across rebuilds for the same user.
  int _hashSeed(int salt) {
    final str = loginUuid + salt.toString();
    var hash = 0;
    for (final ch in str.codeUnits) {
      hash = (hash * 31 + ch) & 0x7FFFFFFF;
    }
    return hash;
  }

  int get matchPercent => 50 + (_hashSeed(1) % 50); // 50–99
  int get trustPercent => 50 + (_hashSeed(2) % 50); // 50–99
  String get replyTime => _replyTimes[_hashSeed(3) % _replyTimes.length];
  bool get isOnline => (_hashSeed(4) % 3) == 0; // ~33% online
  int get distanceKm => 1 + (_hashSeed(5) % 30); // 1–30 km
  String get occupation => _occupations[_hashSeed(6) % _occupations.length];
  String get height => _heights[_hashSeed(7) % _heights.length];
  String get relationshipIntent => _intents[_hashSeed(8) % _intents.length];

  UserEntity toEntity() => UserEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        age: age,
        photoUrl: photoUrl,
        city: city,
        state: state,
        country: country,
        email: email,
        phone: phone,
        gender: gender,
        matchPercent: matchPercent,
        trustPercent: trustPercent,
        replyTime: replyTime,
        isOnline: isOnline,
        distanceKm: distanceKm,
        occupation: occupation,
        height: height,
        relationshipIntent: relationshipIntent,
      );
}
