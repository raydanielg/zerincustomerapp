import 'package:get/get_connect/http/src/response/response.dart';

import 'package:ride_sharing_user_app/core/constants/app_constants.dart';

import '../../../../core/network/api_client.dart';


class BannerRepo{
  final ApiClient apiClient;

  BannerRepo({required this.apiClient});

  Future<Response?> getBannerList() async {
    return await apiClient.getData(AppConstants.bannerUei);
  }
  Future<Response?> updateBannerClickCount(String bannerId) async {
    return await apiClient.postData(AppConstants.bannerCountUpdate, {
      'banner_id' : bannerId
    });
  }
}