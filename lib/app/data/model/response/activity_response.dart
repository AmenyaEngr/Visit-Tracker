import 'package:visit_tracker/app/data/providers/local_data_provider/db_fields/activities_fields.dart';

class ActivityResponse {
  final String? id;
  final String? activity;
  final String? description;
  final String location;
  final String customerId;
  final String? status;
  final String createdAt;

  ActivityResponse({
    this.id,
    this.activity,
    this.description,
    required this.location,
    required this.customerId,
    this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'activity': activity,
    'description': description,
    'location': location,
    'customer_id': customerId,
    'status': status,
    'created_at': createdAt,
  };

  factory ActivityResponse.fromJson(Map<String, dynamic> json) =>
      ActivityResponse(
        id: json['id'],
        activity: json['activity'],
        description: json['description'],
        location: json['location'],
        customerId: json['customer_id'],
        status: json['status'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toMap() {
    return {
      ActivitiesFields.id: id,
      ActivitiesFields.activity: activity,
      ActivitiesFields.description: description,
      ActivitiesFields.location: location,
      ActivitiesFields.customerId: customerId,
      ActivitiesFields.status: status,
      ActivitiesFields.createdAt: createdAt,
    };
  }

  factory ActivityResponse.fromMap(Map<String, dynamic> map) {
    return ActivityResponse(
      id: map[ActivitiesFields.id],
      activity: map[ActivitiesFields.activity],
      description: map[ActivitiesFields.description],
      location: map[ActivitiesFields.location],
      customerId: map[ActivitiesFields.customerId],
      status: map[ActivitiesFields.status],
      createdAt: map[ActivitiesFields.createdAt],
    );
  }
}
