import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visit_tracker/app/data/model/add_activity.dart';
import 'package:visit_tracker/app/data/model/customer_dto.dart';
import 'package:visit_tracker/app/data/providers/api_providers.dart';
import 'package:visit_tracker/app/data/providers/local_data_provider/customer_database.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

import '../../../data/model/response/customer_response.dart';

class HomeController extends GetxController {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController searchCustomerController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  ApiProviders apiProviders = ApiProviders();
  var addCustomerState = false.obs;
  var addActivityState = false.obs;
  Rx<DataState<CustomerResponse>> customers = Rx(Initial());
  String? userId = Supabase.instance.client.auth.currentUser?.id;

  var client = Supabase.instance;

  Future<void> addCustomer() async {
    var userId = client.client.auth.currentUser?.id;
    addCustomerState.value = true;
    var body = CustomerDto(
      customerName: customerNameController.text,
      userId: userId ?? "",
    );
    await apiProviders.addCustomer(body);
    getAllCustomers();
    addCustomerState.value = false;
    customerNameController.clear();
  }

  Future<void> getAllCustomers() async {
    customers.value = Initial();
    await CustomerDatabase.addCustomersToDB();
    customers.value = await CustomerDatabase.getAllCustomers();
  }

  Future<void> addActivity(String customerId) async {
    addActivityState.value = true;
    var body = AddActivityDto(
      activity: activityController.text,
      description: descriptionController.text,
      location: locationController.text,
      status: "Pending",
      customerId: customerId,
      createdAt: DateTime.now().toString(),
      userId: userId ?? "",
    );
    await apiProviders.addActivity(body);
    addActivityState.value = false;
    activityController.clear();
    descriptionController.clear();
    locationController.clear();
  }

  Future<void> searchCustomer(String? searchString) async {
    customers.value = await apiProviders.searchCustomer(searchString, userId);
  }

  @override
  Future<void> onInit() async {
    getAllCustomers();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
