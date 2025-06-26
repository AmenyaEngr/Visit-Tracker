import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visit_tracker/app/common_widgets/input_textfield_widget.dart';
import 'package:visit_tracker/app/data/model/response/activity_response.dart';
import 'package:visit_tracker/app/dimens/dimens.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

import '../controllers/activities_controller.dart';

class ActivitiesView extends GetView<ActivitiesController> {
  const ActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activities'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            InputTextFieldWidget(
              hintText: "Enter activity",
              onChanged: (value) {
                controller.getSearchedActivities(value);
              },
              maxLines: 1,
              editingController: controller.searchActivityController,
              prefixIcon: _buildStatusSection(context),
              suffixIcon: Icons.search,
            ),
            mediumVerticalSpacing,
            Expanded(
              flex: 9,
              child: Obx(() {
                var state = controller.activities.value;

                if (state is Success) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var item = state.data?[index];
                      return _buildActivityItem(item!);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemCount: state.data?.length ?? 0,
                  );
                } else if (state is Error) {
                  return Center(child: Text(state.error ?? ""));
                } else if (state is Initial) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text("No activity"));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  _buildActivityItem(ActivityResponse activity) {
    DateTime inputDate = DateTime.parse(activity.createdAt);
    String date = DateFormat('yyyy-MM-dd').format(inputDate);
    String time = DateFormat("HH:mm:ss").format(inputDate);
    return Container(
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Row(
        children: [
          Checkbox(
            value: activity.status == "Completed" ? true : false,
            onChanged: (newValue) {
              if (activity.status == "Pending") {
                controller.completeActivity(
                  activity.customerId,
                  activity.id ?? "",
                );
              } else if (activity.status == "Cancelled") {
                ScaffoldMessenger.of(Get.context!).showSnackBar(
                  SnackBar(content: Text("Activity was cancelled")),
                );
              }
            },
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.activity ?? "",
                  style:
                      activity.status == "Cancelled"
                          ? AppTextStyles.largeSubHeaderStyle.copyWith(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            decorationThickness: 2.0,
                          )
                          : AppTextStyles.largeSubHeaderStyle,
                ),
                _buildItemDesc("Notes", activity.description, null),
                _buildItemDesc("Location", activity.location, null),
                _buildItemDesc(
                  "Status",
                  activity.status,
                  TextStyle(
                    color:
                        activity.status == "Completed"
                            ? Colors.green
                            : activity.status == "Cancelled"
                            ? Colors.red
                            : Colors.grey,
                    fontSize: normalSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Row(
                  children: [
                    _buildItemDesc("Date", date, null),
                    mediumHorizontalSpacing,
                    _buildItemDesc("Time", time, null),
                  ],
                ),
                Visibility(
                  visible: activity.status == "Pending" ? true : false,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        controller.cancelActivity(
                          activity.customerId,
                          activity.id ?? "",
                        );
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: normalSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildStatusSection(context) {
    final statusOptions = [
      {
        "status": "Completed",
        "action": () => controller.getActivitiesOfStatus("Completed"),
      },
      {
        "status": "Cancelled",
        "action": () => controller.getActivitiesOfStatus("Cancelled"),
      },
      {
        "status": "Pending",
        "action": () => controller.getActivitiesOfStatus("Pending"),
      },
      {"status": "All", "action": () => controller.getCustomerActivities()},
    ];
    return DropdownSearch<Map<String, dynamic>>(
      clickProps: ClickProps(
        borderRadius: BorderRadius.circular(20),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey[300];
          }
          return Colors.grey[200];
        }),
      ),
      mode: Mode.custom,
      items: (filter, cancelToken) => Future.value(statusOptions),
      compareFn: (item1, item2) => item1['status'] == item2['status'],
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
          align: MenuAlign.bottomCenter,
        ),
        fit: FlexFit.loose,
        itemBuilder: (context, item, isDisabled, isSelected) {
          return ListTile(
            selected: isSelected,
            title: Text(item['status'], style: AppTextStyles.subHeaderStyle),
            dense: true,
          );
        },
      ),
      dropdownBuilder: (ctx, selectedItem) => Icon(Icons.filter_list),
      onChanged: (selectedItem) {
        if (selectedItem != null) {
          (selectedItem['action'] as Function)();
        }
      },
    );
  }

  _buildItemDesc(String title, String? desc, TextStyle? style) {
    return Row(children: [Text("$title: "), Text(desc ?? "", style: style)]);
  }
}
