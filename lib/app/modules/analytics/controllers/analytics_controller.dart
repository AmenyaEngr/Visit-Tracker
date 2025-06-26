import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visit_tracker/app/data/providers/api_providers.dart';
import 'package:visit_tracker/app/modules/analytics/models/sf_data.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';
import '../../../data/model/response/activity_response.dart';
import '../models/chart_data.dart';

class AnalyticsController extends GetxController {
  var currentDay = ''.obs;
  final reportPeriod = 'All'.obs;
  Rx<DataState<ActivityResponse>> activities = Rx(Initial());
  ApiProviders apiProviders = ApiProviders();
  String? userId = Supabase.instance.client.auth.currentUser?.id;
  final statusCount = {'Completed': 0, 'Pending': 0, 'Cancelled': 0}.obs;

  Future<void> getAllActivities() async {
    activities.value = Initial();
    var allActivities = await apiProviders.getAllActivities(userId ?? "");

    activities.value = allActivities;

    if (allActivities.data!.isNotEmpty && allActivities.data != null) {
      for (var activity in allActivities.data!) {
        if (statusCount.containsKey(activity.status)) {
          statusCount[activity.status ?? ""] =
              statusCount[activity.status]! + 1;
        }
      }

      buildChartData(activities.value.data);
    }
  }

  buildChartData(List<ActivityResponse>? activities) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 6));

    final Map<DateTime, Map<String, int>> grouped = {};

    if (activities != null) {
      for (var activity in activities) {
        final dateString = activity.createdAt.split('T').first;
        final date = DateTime.tryParse(dateString);

        if (date == null || date.isBefore(sevenDaysAgo)) continue;

        final dayKey = DateTime(date.year, date.month, date.day);
        final status = activity.status ?? 'Unknown';

        if (!grouped.containsKey(dayKey)) {
          grouped[dayKey] = {'Completed': 0, 'Pending': 0, 'Cancelled': 0};
        }

        if (grouped[dayKey]!.containsKey(status)) {
          grouped[dayKey]![status] = grouped[dayKey]![status]! + 1;
        }
      }
    }

    for (int i = 0; i < 7; i++) {
      final date = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: 6 - i));
      grouped.putIfAbsent(
        date,
        () => {'Completed': 0, 'Pending': 0, 'Cancelled': 0},
      );
    }

    final sortedEntries =
        grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return sortedEntries.map((entry) {
      final formattedDate = '${entry.key.month}/${entry.key.day}';
      final counts = entry.value;
      return SfData(
        formattedDate,
        counts['Completed'] ?? 0,
        counts['Pending'] ?? 0,
        counts['Cancelled'] ?? 0,
      );
    }).toList();
  }

  void getCurrentDay() {
    var now = DateTime.now();
    var year = DateTime.now().year;
    var date = now.day;
    var day = DateFormat('E').format(now);

    currentDay.value = '$day $date $year';
  }

  @override
  void onInit() {
    getCurrentDay();
    getAllActivities();
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
