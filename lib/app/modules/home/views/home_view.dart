import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:visit_tracker/app/common_widgets/input_textfield_widget.dart';
import 'package:visit_tracker/app/dimens/dimens.dart';
import 'package:visit_tracker/app/routes/app_pages.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputTextFieldWidget(
                hintText: "Enter customer name",
                editingController: controller.searchCustomerController,
                suffixIcon: Icons.search,
                maxLines: 1,
                onChanged: (value) {
                  controller.searchCustomer(value);
                },
              ),
              Expanded(
                flex: 9,
                child: Obx(() {
                  var state = controller.customers.value;

                  if (state is Success) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        var item = state.data?[index];
                        return _buildCustomerItem(
                          item?.customerName ?? "",
                          item?.id,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: state.data?.length ?? 0,
                    );
                  } else if (state is Error) {
                    return Center(child: Text(state.error ?? ""));
                  } else if (state is Empty) {
                    return Center(child: Text("No customer"));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _buildAddCustomerDialog();
        },
        child: Icon(Icons.add, color: Colors.black87),
      ),
    );
  }

  _buildCustomerItem(String name, String? customerId) {
    return GestureDetector(
      onTap:
          () => Get.toNamed(
            Routes.ACTIVITIES,
            arguments: {'customerId': customerId},
          ),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(height: 40, width: 40, child: Icon(Icons.person)),
                  Text(name, style: AppTextStyles.subHeaderStyle),
                ],
              ),
              IconButton(
                onPressed: () {
                  _buildAddActivity(customerId!);
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAddCustomerDialog() {
    return Get.dialog(
      Dialog(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add a customer", style: AppTextStyles.subHeaderStyle),
              smallVerticalSpacing,
              InputTextFieldWidget(
                hintText: "Enter name",
                labelText: "Name",
                editingController: controller.customerNameController,
              ),
              mediumVerticalSpacing,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Cancel"),
                    ),
                    controller.addCustomerState.value == true
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color:
                                Theme.of(Get.context!).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                          ),
                        )
                        : TextButton(
                          onPressed: () async {
                            await controller.addCustomer();
                            Get.back();
                          },
                          child: Text("Add"),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAddActivity(String customerId) {
    return Get.dialog(
      Dialog(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add a activity", style: AppTextStyles.subHeaderStyle),
              smallVerticalSpacing,
              InputTextFieldWidget(
                hintText: "Enter activity",
                labelText: "Activity",
                editingController: controller.activityController,
              ),
              mediumVerticalSpacing,
              InputTextFieldWidget(
                hintText: "Write notes here",
                labelText: "Notes",
                editingController: controller.descriptionController,
              ),
              mediumVerticalSpacing,
              InputTextFieldWidget(
                hintText: "Enter location",
                labelText: "Location",
                editingController: controller.locationController,
              ),
              mediumVerticalSpacing,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Cancel"),
                    ),
                    controller.addCustomerState.value == true
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color:
                                Theme.of(Get.context!).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                          ),
                        )
                        : TextButton(
                          onPressed: () async {
                            controller.addActivity(customerId);
                            Get.back();
                          },
                          child: Text("Add"),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
