import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ride_sharing_user_app/core/constants/app_constants.dart';
import 'package:ride_sharing_user_app/core/network/api_client.dart';
import 'package:ride_sharing_user_app/core/theme/theme_controller.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/localization/language_model.dart';

// ==================== Auth ====================
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ride_sharing_user_app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:ride_sharing_user_app/features/auth/domain/services/auth_service.dart';
import 'package:ride_sharing_user_app/features/auth/domain/services/auth_service_interface.dart';

// ==================== Splash/Config ====================
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:ride_sharing_user_app/features/splash/domain/repositories/config_repository.dart';
import 'package:ride_sharing_user_app/features/splash/domain/repositories/config_repository_interface.dart';
import 'package:ride_sharing_user_app/features/splash/domain/services/config_service.dart';
import 'package:ride_sharing_user_app/features/splash/domain/services/config_service_interface.dart';

// ==================== Profile ====================
import 'package:ride_sharing_user_app/features/profile/controllers/profile_controller.dart';
import 'package:ride_sharing_user_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:ride_sharing_user_app/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:ride_sharing_user_app/features/profile/domain/services/profile_service.dart';
import 'package:ride_sharing_user_app/features/profile/domain/services/profile_service_interface.dart';

// ==================== Location ====================
import 'package:ride_sharing_user_app/features/location/controllers/location_controller.dart';
import 'package:ride_sharing_user_app/features/location/domain/repositories/location_repository.dart';
import 'package:ride_sharing_user_app/features/location/domain/repositories/location_repository_interface.dart';
import 'package:ride_sharing_user_app/features/location/domain/services/location_service.dart';
import 'package:ride_sharing_user_app/features/location/domain/services/location_service_interface.dart';

// ==================== Ride ====================
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/ride/domain/repositories/ride_repository.dart';
import 'package:ride_sharing_user_app/features/ride/domain/repositories/ride_repository_interface.dart';
import 'package:ride_sharing_user_app/features/ride/domain/services/ride_service.dart';
import 'package:ride_sharing_user_app/features/ride/domain/services/ride_service_interface.dart';

// ==================== Map ====================
import 'package:ride_sharing_user_app/features/map/controllers/map_controller.dart';

// ==================== Trip ====================
import 'package:ride_sharing_user_app/features/trip/controllers/trip_controller.dart';
import 'package:ride_sharing_user_app/features/trip/domain/repositories/trip_repository.dart';
import 'package:ride_sharing_user_app/features/trip/domain/repositories/trip_repository_interface.dart';
import 'package:ride_sharing_user_app/features/trip/domain/services/service_interface.dart';

// ==================== Parcel ====================
import 'package:ride_sharing_user_app/features/parcel/controllers/parcel_controller.dart';
import 'package:ride_sharing_user_app/features/parcel/domain/repositories/parcel_repository.dart';
import 'package:ride_sharing_user_app/features/parcel/domain/repositories/parcel_repository_interface.dart';
import 'package:ride_sharing_user_app/features/parcel/domain/services/parcel_service.dart';
import 'package:ride_sharing_user_app/features/parcel/domain/services/parcel_service_interface.dart';

// ==================== Address ====================
import 'package:ride_sharing_user_app/features/address/controllers/address_controller.dart';
import 'package:ride_sharing_user_app/features/address/domain/repositories/address_repository.dart';
import 'package:ride_sharing_user_app/features/address/domain/repositories/address_repository_interface.dart';
import 'package:ride_sharing_user_app/features/address/domain/services/address_service.dart';
import 'package:ride_sharing_user_app/features/address/domain/services/address_service_interface.dart';

// ==================== Payment ====================
import 'package:ride_sharing_user_app/features/payment/controllers/payment_controller.dart';
import 'package:ride_sharing_user_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:ride_sharing_user_app/features/payment/domain/repositories/payment_repository_interface.dart';
import 'package:ride_sharing_user_app/features/payment/domain/services/payment_service.dart';
import 'package:ride_sharing_user_app/features/payment/domain/services/payment_service_interface.dart';

// ==================== Coupon ====================
import 'package:ride_sharing_user_app/features/coupon/controllers/coupon_controller.dart';
import 'package:ride_sharing_user_app/features/coupon/domain/repositories/coupon_repository.dart';
import 'package:ride_sharing_user_app/features/coupon/domain/repositories/coupon_repository_interface.dart';
import 'package:ride_sharing_user_app/features/coupon/domain/services/coupon_service.dart';
import 'package:ride_sharing_user_app/features/coupon/domain/services/coupon_service_interface.dart';

// ==================== Wallet ====================
import 'package:ride_sharing_user_app/features/wallet/controllers/wallet_controller.dart';
import 'package:ride_sharing_user_app/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:ride_sharing_user_app/features/wallet/domain/repositories/wallet_repository_interface.dart';
import 'package:ride_sharing_user_app/features/wallet/domain/services/wallet_service.dart';
import 'package:ride_sharing_user_app/features/wallet/domain/services/wallet_service_interface.dart';

// ==================== Message ====================
import 'package:ride_sharing_user_app/features/message/controllers/message_controller.dart';
import 'package:ride_sharing_user_app/features/message/domain/repositories/message_repository.dart';
import 'package:ride_sharing_user_app/features/message/domain/repositories/message_repository_interface.dart';
import 'package:ride_sharing_user_app/features/message/domain/services/message_service.dart';
import 'package:ride_sharing_user_app/features/message/domain/services/message_service_interface.dart';

// ==================== Notification ====================
import 'package:ride_sharing_user_app/features/notification/controllers/notification_controller.dart';
import 'package:ride_sharing_user_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:ride_sharing_user_app/features/notification/domain/repositories/notification_repository_interface.dart';
import 'package:ride_sharing_user_app/features/notification/domain/services/notification_service.dart';
import 'package:ride_sharing_user_app/features/notification/domain/services/notification_service_interface.dart';

// ==================== Dashboard ====================
import 'package:ride_sharing_user_app/features/dashboard/controllers/bottom_menu_controller.dart';

// ==================== Onboard ====================
import 'package:ride_sharing_user_app/features/onboard/controllers/on_board_page_controller.dart';

// ==================== Home/Category ====================
import 'package:ride_sharing_user_app/features/home/controllers/category_controller.dart';
import 'package:ride_sharing_user_app/features/home/domain/repositories/category_repo.dart';

// ==================== Offer ====================
import 'package:ride_sharing_user_app/features/my_offer/controller/offer_controller.dart';
import 'package:ride_sharing_user_app/features/my_offer/domain/repositories/offer_repository.dart';
import 'package:ride_sharing_user_app/features/my_offer/domain/repositories/offer_repository_interface.dart';
import 'package:ride_sharing_user_app/features/my_offer/domain/services/offer_service.dart';
import 'package:ride_sharing_user_app/features/my_offer/domain/services/offer_service_interface.dart';

// ==================== Level ====================
import 'package:ride_sharing_user_app/features/my_level/controller/level_controller.dart';
import 'package:ride_sharing_user_app/features/my_level/domain/repositories/level_repository.dart';
import 'package:ride_sharing_user_app/features/my_level/domain/repositories/level_repository_interface.dart';
import 'package:ride_sharing_user_app/features/my_level/domain/services/level_service.dart';
import 'package:ride_sharing_user_app/features/my_level/domain/services/level_service_interface.dart';

// ==================== Refer and Earn ====================
import 'package:ride_sharing_user_app/features/refer_and_earn/controllers/refer_and_earn_controller.dart';
import 'package:ride_sharing_user_app/features/refer_and_earn/domain/repositories/refer_earn_repository.dart';
import 'package:ride_sharing_user_app/features/refer_and_earn/domain/repositories/refer_earn_repository_interface.dart';
import 'package:ride_sharing_user_app/features/refer_and_earn/domain/services/refer_earn_service.dart';
import 'package:ride_sharing_user_app/features/refer_and_earn/domain/services/refer_earn_service_interface.dart';

// ==================== Support ====================
import 'package:ride_sharing_user_app/features/support/controllers/help_support_controller.dart';

// ==================== Safety ====================
import 'package:ride_sharing_user_app/features/safety_setup/controllers/safety_alert_controller.dart';
import 'package:ride_sharing_user_app/features/safety_setup/domain/repositories/safety_alert_repository.dart';
import 'package:ride_sharing_user_app/features/safety_setup/domain/repositories/safety_alert_repository_interface.dart';
import 'package:ride_sharing_user_app/features/safety_setup/domain/services/safety_alert_service.dart';
import 'package:ride_sharing_user_app/features/safety_setup/domain/services/safety_alert_service_interface.dart';

// ==================== Refund ====================
import 'package:ride_sharing_user_app/features/refund_request/controllers/refund_request_controller.dart';
import 'package:ride_sharing_user_app/features/refund_request/domain/repositories/refund_request_repository.dart';
import 'package:ride_sharing_user_app/features/refund_request/domain/repositories/refund_request_repository_interface.dart';
import 'package:ride_sharing_user_app/features/refund_request/domain/services/refund_request_service.dart';
import 'package:ride_sharing_user_app/features/refund_request/domain/services/refund_request_service_interface.dart';

import '../features/trip/domain/services/service.dart';





// ==================== Auth ====================

// ==================== Splash/Config ====================

// ==================== Profile ====================

// ==================== Location ====================

// ==================== Ride ====================

// ==================== Map ====================

// ==================== Trip ====================


// ==================== Parcel ====================

// ==================== Address ====================

// ==================== Payment ====================

// ==================== Coupon ====================

// ==================== Wallet ====================

// ==================== Message ====================

// ==================== Notification ====================

// ==================== Dashboard ====================

// ==================== Onboard ====================

// ==================== Home/Category ====================

// ==================== Offer ====================

// ==================== Level ====================

// ==================== Refer and Earn ====================

// ==================== Support ====================

// ==================== Safety ====================

// ==================== Refund ====================

Future<Map<String, Map<String, String>>> init() async {
  // ==================== Core Dependencies ====================
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // API Client
  Get.lazyPut(() => ApiClient(
    appBaseUrl: AppConstants.baseUrl,
    sharedPreferences: Get.find(),
  ));

  // ==================== CRITICAL: Theme & Localization Controllers ====================
  // These MUST be registered before MyApp() is instantiated
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

  // ==================== Repositories ====================
  Get.lazyPut<ConfigRepositoryInterface>(() => ConfigRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut<AuthRepositoryInterface>(() => AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut<ProfileRepositoryInterface>(() => ProfileRepository(apiClient: Get.find()));
  Get.lazyPut<LocationRepositoryInterface>(() => LocationRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut<RideRepositoryInterface>(() => RideRepository(apiClient: Get.find()));
  Get.lazyPut<TripRepositoryInterface>(() => TripRepository(apiClient: Get.find()));
  Get.lazyPut<ParcelRepositoryInterface>(() => ParcelRepository(apiClient: Get.find()));
  Get.lazyPut<AddressRepositoryInterface>(() => AddressRepository(apiClient: Get.find()));
  Get.lazyPut<PaymentRepositoryInterface>(() => PaymentRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut<CouponRepositoryInterface>(() => CouponRepository(apiClient: Get.find()));
  Get.lazyPut<WalletRepositoryInterface>(() => WalletRepository(apiClient: Get.find()));
  Get.lazyPut<MessageRepositoryInterface>(() => MessageRepository(apiClient: Get.find()));
  Get.lazyPut<NotificationRepositoryInterface>(() => NotificationRepository(apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut<OfferRepositoryInterface>(() => OfferRepository(apiClient: Get.find()));
  Get.lazyPut<LevelRepositoryInterface>(() => LevelRepository(apiClient: Get.find()));
  Get.lazyPut<ReferEarnRepositoryInterface>(() => ReferEarnRepository(apiClient: Get.find()));
  Get.lazyPut<SafetyAlertRepositoryInterface>(() => SafetyAlertRepository(apiClient: Get.find()));
  Get.lazyPut<RefundRequestRepositoryInterface>(() => RefundRequestRepository(apiClient: Get.find()));

  // ==================== Services ====================
  Get.lazyPut<ConfigServiceInterface>(() => ConfigService(configRepositoryInterface: Get.find()));
  Get.lazyPut<AuthServiceInterface>(() => AuthService(authRepositoryInterface: Get.find()));
  Get.lazyPut<ProfileServiceInterface>(() => ProfileService(profileRepositoryInterface: Get.find()));
  Get.lazyPut<LocationServiceInterface>(() => LocationService(locationRepositoryInterface: Get.find()));
  Get.lazyPut<RideServiceInterface>(() => RideService(rideRepositoryInterface: Get.find()));
  Get.lazyPut<TripServiceInterface>(() => TripService(tripRepositoryInterface: Get.find()));
  Get.lazyPut<ParcelServiceInterface>(() => ParcelService(parcelRepositoryInterface: Get.find()));
  Get.lazyPut<AddressServiceInterface>(() => AddressService(addressRepositoryInterface: Get.find()));
  Get.lazyPut<PaymentServiceInterface>(() => PaymentService(paymentRepositoryInterface: Get.find()));
  Get.lazyPut<CouponServiceInterface>(() => CouponService(couponRepositoryInterface: Get.find()));
  Get.lazyPut<WalletServiceInterface>(() => WalletService(walletRepositoryInterface: Get.find()));
  Get.lazyPut<MessageServiceInterface>(() => MessageService(messageRepositoryInterface: Get.find()));
  Get.lazyPut<NotificationServiceInterface>(() => NotificationService(notificationRepositoryInterface: Get.find()));
  Get.lazyPut<OfferServiceInterface>(() => OfferService(offerRepositoryInterface: Get.find()));
  Get.lazyPut<LevelServiceInterface>(() => LevelService(levelRepositoryInterface: Get.find()));
  Get.lazyPut<ReferEarnServiceInterface>(() => ReferEarnService(referEarnRepositoryInterface: Get.find()));
  Get.lazyPut<SafetyAlertServiceInterface>(() => SafetyAlertService(safetyAlertRepositoryInterface: Get.find()));
  Get.lazyPut<RefundRequestServiceInterface>(() => RefundRequestService(refundRequestRepositoryInterface: Get.find()));

  // ==================== Controllers ====================
  // Config/Splash Controller
  Get.lazyPut(() => ConfigController(configServiceInterface: Get.find()));

  // Auth Controller
  Get.lazyPut(() => AuthController(authServiceInterface: Get.find()));

  // Profile Controller
  Get.lazyPut(() => ProfileController(profileServiceInterface: Get.find()));

  // Location Controller
  Get.lazyPut(() => LocationController(locationServiceInterface: Get.find()));

  // Ride Controller
  Get.lazyPut(() => RideController(rideServiceInterface: Get.find()));

  // Map Controller
  Get.lazyPut(() => MapController());

  // Trip Controller
  Get.lazyPut(() => TripController(tripServiceInterface: Get.find()));

  // Parcel Controller
  Get.lazyPut(() => ParcelController(parcelServiceInterface: Get.find()));

  // Address Controller
  Get.lazyPut(() => AddressController(addressServiceInterface: Get.find()));

  // Payment Controller
  Get.lazyPut(() => PaymentController(paymentServiceInterface: Get.find()));

  // Coupon Controller
  Get.lazyPut(() => CouponController(couponServiceInterface: Get.find()));

  // Wallet Controller
  Get.lazyPut(() => WalletController(walletService: Get.find()));

  // Message Controller
  Get.lazyPut(() => MessageController(messageServiceInterface: Get.find()));

  // Notification Controller
  Get.lazyPut(() => NotificationController(notificationServiceInterface: Get.find()));

  // Dashboard Controller
  Get.lazyPut(() => BottomMenuController());

  // Onboard Controller
  Get.lazyPut(() => OnBoardController());

  // Category Controller
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));

  // Offer Controller
  Get.lazyPut(() => OfferController(offerServiceInterface: Get.find()));

  // Level Controller
  Get.lazyPut(() => LevelController(levelServiceInterface: Get.find()));

  // Refer and Earn Controller
  Get.lazyPut(() => ReferAndEarnController(referEarnServiceInterface: Get.find()));

  // Help Support Controller
  Get.lazyPut(() => HelpSupportController());

  // Safety Alert Controller
  Get.lazyPut(() => SafetyAlertController(safetyAlertServiceInterface: Get.find()));

  // Refund Request Controller
  Get.lazyPut(() => RefundRequestController(refundRequestServiceInterface: Get.find()));

  // ==================== Load Languages ====================
  Map<String, Map<String, String>> languages = {};

  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
  }

  return languages;
}

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateToDateAndTimeAm(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalString(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(dateTime).toLocal());
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('dd MMM yyyy, ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd-MM-yy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parse(time));
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static String isoDateTimeStringToLocalTime(String dateTime) {
    return DateFormat(_timeFormatter()).format(isoStringToLocalDate(dateTime));
  }

  static String isoDateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(dateTime).toLocal());
  }

  static String isoDateTimeStringToDifferentWithCurrentTime(String dateTime) {
    DateTime messageTime = isoStringToLocalDate(dateTime);
    int minutes = DateTime.now().difference(messageTime).inMinutes;
    if (minutes <= 20) {
      return '$minutes ${'min_ago'.tr}';
    } else if (minutes > 20 && minutes <= 1440) {
      return DateFormat(_timeFormatter()).format(messageTime);
    } else if (minutes > 1440 && minutes <= 2880) {
      return '${'yesterday'.tr}, ${DateFormat(_timeFormatter()).format(messageTime)}';
    } else {
      return isoStringToDateTimeString(dateTime);
    }
  }

  static String isoStringToLocalDateAndMonthOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateTimeToDateAndMonthOnly(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String _timeFormatter() {
    return 'hh:mm a';
  }

  static String convertFromMinute(int minMinute, int maxMinute) {
    int firstValue = minMinute;
    int secondValue = maxMinute;
    String type = 'min';
    if (minMinute >= 525600) {
      firstValue = (minMinute / 525600).floor();
      secondValue = (maxMinute / 525600).floor();
      type = 'year';
    } else if (minMinute >= 43200) {
      firstValue = (minMinute / 43200).floor();
      secondValue = (maxMinute / 43200).floor();
      type = 'month';
    } else if (minMinute >= 10080) {
      firstValue = (minMinute / 10080).floor();
      secondValue = (maxMinute / 10080).floor();
      type = 'week';
    } else if (minMinute >= 1440) {
      firstValue = (minMinute / 1440).floor();
      secondValue = (maxMinute / 1440).floor();
      type = 'day';
    } else if (minMinute >= 60) {
      firstValue = (minMinute / 60).floor();
      secondValue = (maxMinute / 60).floor();
      type = 'hour';
    }
    return '$firstValue-$secondValue ${type.tr}';
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('${_timeFormatter()} | d-MMM-yyyy ').format(dateTime.toLocal());
  }

  static String localToIsoString(DateTime dateTime) {
    return DateFormat('d MMMM, hh:mm aa').format(dateTime.toLocal());
  }

  static String stringToLocalDateTime(String dateTime) {
    return DateFormat('dd/MM/yyyy - hh:mm a').format(DateFormat('yyyy-MM-dd HH:mm').parse(dateTime));
  }

  static String isoStringToTripHistoryFormat(String dateTime) {
    return DateFormat('dd MMM yy,  ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }

  static String stringDateTimeToTimeOnly(String dateTime) {
    return DateFormat(_timeFormatter()).format(DateFormat('yyyy-MM-dd HH:mm').parse(dateTime));
  }

  static String tripDetailsShowFormat(String dateTime) {
    return DateFormat('dd MMM yyyy, ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }
}