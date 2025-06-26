class CustomerDto {
  String customerName;
  String userId;

  CustomerDto({required this.customerName, required this.userId});

  Map<String, dynamic> toJson() => {'customer_name': customerName, 'user_id': userId};

  factory CustomerDto.fromJson(Map<String, dynamic> json) =>
      CustomerDto(customerName: json['customer_name'], userId: json['user_id']);
}
