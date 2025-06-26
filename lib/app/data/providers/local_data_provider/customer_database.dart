import 'package:sqflite/sqflite.dart';
import 'package:visit_tracker/app/data/model/response/customer_response.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

import '../api_providers.dart';
import 'create_database.dart';
import 'db_fields/customer_fields.dart';

class CustomerDatabase {
  static ApiProviders apiProviders = ApiProviders();

  static Future<List<Object?>> addCustomersToDB() async {
    List<CustomerResponse>? customers = await apiProviders.getAllCustomers();
    if (customers == null || customers.isEmpty) {
      return [];
    }

    final db = await CreateDatabase.getDB();

    try {
      Batch batch = db.batch();

      for (CustomerResponse customer in customers) {
        batch.insert(
          CustomerFields.customerTableName,
          customer.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return await batch.commit();
    } catch (error) {
      print("===========>error getting customers from db_fields $error");
      return [];
    }
  }

  static Future<DataState<CustomerResponse>> getAllCustomers() async {
    final db = await CreateDatabase.getDB();

    try {
      final List<Map<String, dynamic>> customers = await db.query(
        CustomerFields.customerTableName,
      );

      var response = List.generate(customers.length, (i) {
        return CustomerResponse.fromMap(customers[i]);
      });

      return customers.isEmpty ? const Empty() : Success(response);
    } catch (error) {
      print("===========>error getting customers from db_fields $error");
      return Error(error.toString());
    }
  }
}
