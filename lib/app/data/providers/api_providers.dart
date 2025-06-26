import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visit_tracker/app/data/model/response/activity_response.dart';
import 'package:visit_tracker/app/data/model/add_activity.dart';
import 'package:visit_tracker/app/data/model/customer_dto.dart';
import 'package:visit_tracker/app/data/model/register_user_dto.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

import '../model/response/customer_response.dart';

class ApiProviders extends GetConnect {
  static Supabase supabase = Supabase.instance;

  Future<AuthResponse?> signUp(
    RegisterUserDto userData,
    String password,
    String email,
  ) async {
    try {
      return await supabase.client.auth.signUp(
        email: email,
        password: password,
        data: userData.toJson(),
      );
    } catch (error) {
      print("=============> error $error");
      return _handleError(error);
    }
  }

  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      var response = await supabase.client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      return response;
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<bool> signOut() async {
    try {
      await supabase.client.auth.signOut();
      return true;
    } catch (error) {
      _handleError(error);
      return false;
    }
  }

  Future<PostgrestResponse?> addCustomer(CustomerDto customer) async {
    try {
      return await supabase.client.from('customer').insert(customer.toJson());
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<List<CustomerResponse>?> getAllCustomers() async {
    try {
      String? userId = supabase.client.auth.currentUser?.id;
      final response = await supabase.client
          .from('customer')
          .select()
          .eq('user_id', userId ?? "")
          .order('created_at', ascending: true);

      final List<dynamic> data = response as List<dynamic>;
      final customers =
          data.map((json) => CustomerResponse.fromJson(json)).toList();

      return customers;
    } catch (error) {
      if (error is PostgrestException) {
        _showScaffoldMessage(error.details.toString());
        return [];
      } else {
        // _showScaffoldMessage("An error occurred");
        return [];
      }
    }
  }

  Future<PostgrestResponse?> addActivity(AddActivityDto activity) async {
    try {
      return await supabase.client.from('activity').insert(activity.toJson());
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<List<ActivityResponse>> getCustomerActivities(
    String customerId,
  ) async {
    try {
      final response = await supabase.client
          .from('activity')
          .select()
          .eq('customer_id', customerId)
          .order('created_at', ascending: true);
      final List<dynamic> data = response as List<dynamic>;
      final activities =
          data.map((json) => ActivityResponse.fromJson(json)).toList();

      return activities;
    } catch (error) {
      if (error is PostgrestException) {
        _showScaffoldMessage(error.details.toString());
        return [];
      } else {
        // _showScaffoldMessage("An error occurred");
        return [];
      }
    }
  }

  Future<DataState<ActivityResponse>> getAllActivities(String userId) async {
    try {
      final response = await supabase.client
          .from('activity')
          .select()
          .eq('user_id', userId);

      final List<dynamic> data = response as List<dynamic>;
      final allActivities =
          data.map((json) => ActivityResponse.fromJson(json)).toList();

      return allActivities.isEmpty ? const Empty() : Success(allActivities);
    } catch (error) {
      if (error is PostgrestException) {
        return Error(error.details.toString());
      } else {
        return Error("An error occurred");
      }
    }
  }

  Future<PostgrestResponse?> updateActivity(
    String activityId,
    String status,
  ) async {
    try {
      final Map<String, dynamic> updatedStatus = {'status': status};
      final response = await supabase.client
          .from('activity')
          .update(updatedStatus)
          .eq('id', activityId);
      return response;
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<DataState<CustomerResponse>> searchCustomer(
    String? customerName,
    userId,
  ) async {
    try {
      final response = await supabase.client
          .from('customer')
          .select()
          .eq('user_id', userId)
          .ilike('customer_name', '%$customerName%')
          .order('created_at', ascending: false);
      final List<dynamic> data = response as List<dynamic>;
      final customers =
          data.map((json) => CustomerResponse.fromJson(json)).toList();
      return customers.isEmpty ? const Empty() : Success(customers);
    } catch (error) {
      if (error is PostgrestException) {
        return Error(error.details.toString());
      } else {
        return Error("An error occurred");
      }
    }
  }

  Future<DataState<ActivityResponse>> searchActivity(
    String? activityName,
    customerId,
  ) async {
    try {
      final response = await supabase.client
          .from('activity')
          .select()
          .eq('customer_id', customerId)
          .ilike('activity', '%$activityName%')
          .order('created_at', ascending: false);
      final List<dynamic> data = response as List<dynamic>;
      final activities =
          data.map((json) => ActivityResponse.fromJson(json)).toList();
      return activities.isEmpty ? const Empty() : Success(activities);
    } catch (error) {
      if (error is PostgrestException) {
        return Error(error.details.toString());
      } else {
        return Error("An error occurred");
      }
    }
  }

  Future<DataState<ActivityResponse>> getForStatus(
    String status,
    customerId,
  ) async {
    try {
      final response = await supabase.client
          .from('activity')
          .select()
          .eq('status', status)
          .eq('customer_id', customerId)
          .order('created_at', ascending: false);
      final List<dynamic> data = response as List<dynamic>;
      final activities =
          data.map((json) => ActivityResponse.fromJson(json)).toList();
      return activities.isEmpty ? const Empty() : Success(activities);
    } catch (error) {
      if (error is PostgrestException) {
        return Error(error.details.toString());
      } else {
        return Error("An error occurred");
      }
    }
  }

  T? _handleError<T>(dynamic error) {
    if (error is PostgrestException) {
      _showScaffoldMessage(error.details.toString());
    } else if (error is AuthApiException) {
      _showScaffoldMessage(error.message);
    } else {
      _showScaffoldMessage("An error occurred");
    }

    return null;
  }

  _showScaffoldMessage(String error) {
    ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(SnackBar(content: Text(error)));
  }
}
