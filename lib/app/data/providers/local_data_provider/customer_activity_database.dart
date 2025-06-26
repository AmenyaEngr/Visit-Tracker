import 'package:sqflite/sqflite.dart';
import 'package:visit_tracker/app/data/model/response/activity_response.dart';
import 'package:visit_tracker/app/data/providers/api_providers.dart';
import 'package:visit_tracker/app/data/providers/local_data_provider/db_fields/activities_fields.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

import 'create_database.dart';

class CustomerActivityDatabase {
  static ApiProviders apiProviders = ApiProviders();

  static Future<List<Object?>> addActivitiesToDB(String customerId) async {
    List<ActivityResponse>? activities = await apiProviders
        .getCustomerActivities(customerId);


    if (activities.isEmpty) {
      return [];
    }

    final db = await CreateDatabase.getDB();

    try {
      Batch batch = db.batch();
      for (ActivityResponse activity in activities) {
        batch.insert(
          ActivitiesFields.activitiesTableName,
          activity.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      return await batch.commit();
    } catch (error) {
      print("===========>error adding activities to db $error");
      return [];
    }
  }

  static Future<DataState<ActivityResponse>> getAllCustomerActivities(
    String customerId,
  ) async {
    final db = await CreateDatabase.getDB();

    try {
      final List<Map<String, dynamic>> activities = await db.query(
        ActivitiesFields.activitiesTableName,
        where: '${ActivitiesFields.customerId} = ?',
        whereArgs: [customerId],
      );

      var response = List.generate(activities.length, (i) {
        return ActivityResponse.fromMap(activities[i]);
      });

      return activities.isEmpty ? const Empty() : Success(response);
    } catch (error) {
      return Error(error.toString());
    }
  }
}
