import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/login_helper.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:video_player/video_player.dart';


class SplashScreen extends StatefulWidget {
  final Map<String,dynamic>? notificationData;
  final String? userName;
  const SplashScreen({super.key, this.notificationData, this.userName});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<List<ConnectivityResult>>? _onConnectivityChanged;
  VideoPlayerController? _videoController;
  bool _isConnected = true;
  bool _videoDone = false;
  bool _navigated = false;
  Timer? _fallbackTimer;


  @override
  void initState() {
    super.initState();

    Get.find<ConfigController>().initSharedData();

    _checkConnectivity();
    _initIntroVideo();

    _fallbackTimer = Timer(const Duration(seconds: 12), () {
      if (!_videoDone) {
        _videoDone = true;
        _tryProceed();
      }
    });
  }

  Future<void> _initIntroVideo() async {
    try {
      final controller = VideoPlayerController.asset('assets/App INtro.mp4');
      _videoController = controller;
      await controller.initialize();
      if (!mounted) return;
      await controller.setLooping(false);
      setState(() {});
      await controller.play();
      controller.addListener(() {
        final value = controller.value;
        if (!_videoDone && value.isInitialized && !value.isPlaying && value.position >= value.duration) {
          _videoDone = true;
          _tryProceed();
        }
      });
    } catch (_) {
      debugPrint('Intro video failed to initialize/play');
      _videoDone = true;
      _tryProceed();
    }
  }

  void _tryProceed() {
    if (_navigated) return;
    if (!_videoDone) return;
    if (!_isConnected) return;
    _navigated = true;
    LoginHelper().handleIncomingLinks(widget.notificationData, widget.userName);
  }

  void _checkConnectivity(){
    bool isFirst = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      bool isConnected = result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile);
      _isConnected = isConnected;
      if(!isFirst || !isConnected) {
        ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();
        ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          backgroundColor: isConnected ? Colors.green : Colors.red,
          duration: Duration(seconds: isConnected ? 3 : 6000),
          content: Text(
            isConnected ? 'connected'.tr : 'no_connection'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(isConnected) {
          _tryProceed();
        }
      }else{
        ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();
        ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
        _tryProceed();
      }
      isFirst = false;
    });
  }



  @override
  void dispose() {
    _onConnectivityChanged?.cancel();
    _videoController?.dispose();
    _fallbackTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_videoController != null && _videoController!.value.isInitialized)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController!.value.size.width,
                  height: _videoController!.value.size.height,
                  child: VideoPlayer(_videoController!),
                ),
              )
            else
              Container(color: Colors.black),

            if (_videoController == null || !_videoController!.value.isInitialized)
              Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
              ),

            Positioned(
              right: 16,
              top: MediaQuery.of(context).padding.top + 12,
              child: TextButton(
                onPressed: () {
                  _videoDone = true;
                  _tryProceed();
                },
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
