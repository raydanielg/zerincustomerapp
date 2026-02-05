import 'package:get/get.dart';

import 'package:ride_sharing_user_app/features/my_level/domain/model/level_model.dart';
import 'package:ride_sharing_user_app/features/my_level/domain/services/level_service_interface.dart';

import '../../../core/network/api_checker.dart';

class LevelController extends GetxController implements GetxService{
  final LevelServiceInterface levelServiceInterface;

  LevelController({required this.levelServiceInterface});

  LevelModel? _levelModel;
  LevelModel? get levelModel => _levelModel;

  Future<void> getProfileLevelInfo() async{
    Response response = await levelServiceInterface.getProfileLevelInfo();
    if(response.statusCode == 200){
      _levelModel = LevelModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

}