
import '../../providers/local_data_provider/db_fields/customer_fields.dart';

class CustomerResponse {
  String? id;
  String customerName;

  CustomerResponse({required this.id, required this.customerName});

  Map<String, dynamic> toJson() => {'id': id, 'customer_name': customerName};

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(id: json['id'], customerName: json['customer_name']);

  Map<String, dynamic> toMap() {
    return {CustomerFields.id: id, CustomerFields.customerName: customerName};
  }

  factory CustomerResponse.fromMap(Map<String, dynamic> map) {
    return CustomerResponse(
      id: map[CustomerFields.id],
      customerName: map[CustomerFields.customerName],
    );
  }
}
