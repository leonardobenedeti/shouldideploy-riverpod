import 'dart:convert';

class ShouldDidDeployToday {
  String timezone;
  DateTime date;
  bool shouldideploy;
  String message;

  ShouldDidDeployToday({
    required this.timezone,
    required this.date,
    required this.shouldideploy,
    required this.message,
  });

  factory ShouldDidDeployToday.fromMap(Map<String, dynamic> map) {
    return ShouldDidDeployToday(
      timezone: map['timezone'] as String,
      date: DateTime.parse(map['date']),
      shouldideploy: map['shouldideploy'] as bool,
      message: map['message'] as String,
    );
  }

  factory ShouldDidDeployToday.fromJson(String source) =>
      ShouldDidDeployToday.fromMap(json.decode(source) as Map<String, dynamic>);
}
