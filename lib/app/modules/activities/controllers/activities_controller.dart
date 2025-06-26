import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visit_tracker/app/data/model/response/activity_response.dart';
import 'package:visit_tracker/app/data/providers/api_providers.dart';
import 'package:visit_tracker/app/data/providers/local_data_provider/customer_activity_database.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

class ActivitiesController extends GetxController {
  TextEditingController searchActivityController = TextEditingController();
  final String customerId = Get.arguments['customerId'];
  String? userId = Supabase.instance.client.auth.currentUser?.id;
  ApiProviders apiProviders = ApiProviders();
  Rx<DataState<ActivityResponse>> activities = Rx(Initial());
  var status = 'Daily'.obs;

  Future<void> getCustomerActivities() async {
    activities.value = Initial();

    await CustomerActivityDatabase.addActivitiesToDB(customerId);

    activities.value = await CustomerActivityDatabase.getAllCustomerActivities(
      customerId,
    );
  }

  Future<void> cancelActivity(String customerId, String activityId) async {
    activities.value = Initial();
    var response = await apiProviders.updateActivity(activityId, "Cancelled");

    if (response?.data != null) {
      await getCustomerActivities();
    } else {
      await getCustomerActivities();
    }
  }

  Future<void> completeActivity(String customerId, String activityId) async {
    activities.value = Initial();
    var response = await apiProviders.updateActivity(activityId, "Completed");

    if (response?.data != null) {
      await getCustomerActivities();
    } else {
      await getCustomerActivities();
    }
  }

  Future<void> getSearchedActivities(String? activityName) async {
    activities.value = await apiProviders.searchActivity(activityName, userId);
  }

  Future<void> getActivitiesOfStatus(String status) async {
    activities.value = Initial();
    activities.value = await apiProviders.getForStatus(status, customerId);
  }

  @override
  void onInit() {
    getCustomerActivities();
    super.onInit();
  }
}
