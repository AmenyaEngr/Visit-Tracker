class AddActivityDto {
  final String activity;
  final String? description;
  final String location;
  final String customerId;
  final String? status;
  final String createdAt;
  final String userId;

  AddActivityDto({
    required this.activity,
    this.description,
    required this.location,
    required this.customerId,
    this.status,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    'activity': activity,
    'description': description,
    'location': location,
    'customer_id': customerId,
    'status': status,
    'created_at': createdAt,
    'user_id': userId,
  };

  factory AddActivityDto.fromJson(Map<String, dynamic> json) => AddActivityDto(
    activity: json['activity'],
    description: json['description'],
    location: json['location'],
    customerId: json['customer_id'],
    status: json['status'],
    createdAt: json['created_at'],
    userId: json['user_id'],
  );
}
