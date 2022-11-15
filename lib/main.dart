import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/Screens/AboutUsScreen.dart';
import 'package:exercise_app/Screens/CustomWorkouts.dart';
import 'package:exercise_app/Screens/HomeScreen.dart';
import 'package:exercise_app/Screens/SetUpProfileScreen.dart';
import 'package:exercise_app/Screens/SplashScreen.dart';
import 'package:exercise_app/Themes.dart';
import 'package:exercise_app/notificationHelper.dart';
import 'package:exercise_app/testing/DatabaseTesting.dart';
import 'package:exercise_app/CustomWidgets/CustomAds.dart';
import 'package:exercise_app/Screens/StartExercise.dart';
import 'package:exercise_app/testing/MyVideoPlayer.dart';
//import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:exercise_app/Screens/SelectExercise.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:exercise_app/Screens/AllWorkouts.dart';
import 'AllText.dart';
import 'CustomWidgets/VoiceAssistant.dart';
import 'LocalDatabase/ProgressClass.dart';
import 'Screens/IntroSlider.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/CustomWidgets/CustomSettingsList.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';

import 'CustomWidgets/CustomTextWidget.dart';
import 'CustomWidgets/CustomTextWidget.dart';
import 'Screens/Settings.dart';
import 'Screens/TabsScreen.dart';
import 'Screens/TabsScreen.dart';
import 'package:exercise_app/Screens/SelectWorkouts.dart';
import 'package:timezone/data/latest.dart' as tz;

CustomTextWidget customTextWidget = CustomTextWidget(), t = CustomTextWidget();
CustomDialogues customDialogues = CustomDialogues();
VoiceAssistant voiceAssistant;
CustomSettingsListTile customSettingsListTile = CustomSettingsListTile(),
    lt = CustomSettingsListTile();
//CustomAds customAds = CustomAds();
const String SERVER_ADDRESS = "https://fitness.barquecontech.com";
const String IMAGE_ADDRESS_HOME =
    "https://fitness.barquecontech.com/images/menu_cat_icon/";
String IMAGE_URL_MENU_ITEM =
    "https://fitness.barquecontech.com/images/menu_item_icon/";

NotificationHelper notificationHelper = NotificationHelper();
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
const SELECT_WORKOUTS_LIMIT = 3;
double HEIGHT = 800;
double WIDTH = 800;
// CustomAds customAds = CustomAds();
final nativeAdController = NativeAdmobController();

String NATIVE_AD_ID = NativeAd.testAdUnitId;
String INTERSTITIAL_AD_ID = InterstitialAd.testAdUnitId;

bool DISPLAY_ADS = false;
bool PLAY_YOUTUBE_VIDEOS = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: BLACK, statusBarIconBrightness: Brightness.light));
  await Firebase.initializeApp();

  nativeAdController.setNonPersonalizedAds(false);
  nativeAdController.stateChanged.listen((event) {
    print(event);
  });

  MobileAds.instance.initialize().then((InitializationStatus status) {
    print('Initialization done: ${status.adapterStatuses}');
    MobileAds.instance
        .updateRequestConfiguration(RequestConfiguration(
      tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified,
    ))
        .then((value) {
      //createInterstitialAd();
      //createRewardedAd();
    });
  });
  //
  // await FacebookAudienceNetwork.init(
  //   //testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
  // );

  //await MobileAds.initialize();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ProgressClassAdapter());
  Hive.registerAdapter(CustomWorkoutsClassAdapter());
  Hive.registerAdapter(CustomWorkoutCreateClassAdapter());
  tz.initializeTimeZones();

  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("en", "US"),
      Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      Locale('ar', 'AE'),
    ],
    //locale: Locale('ar', 'AE'),
  ));
}
