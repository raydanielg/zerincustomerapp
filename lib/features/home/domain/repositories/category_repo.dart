import 'package:get/get_connect/http/src/response/response.dart';

import 'package:ride_sharing_user_app/core/constants/app_constants.dart';

import '../../../../core/network/api_client.dart';


class CategoryRepo{
  final ApiClient apiClient;

  CategoryRepo({required this.apiClient});

  Future<Response?> getCategoryList() async {
    return await apiClient.getData(AppConstants.vehicleMainCategory);
  }

}