import 'dart:async';
import 'dart:ui';

import 'package:background_sms/background_sms.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';

import 'package:vibration/vibration.dart';


// sendMessage(String messageBody) async {
//   List<TContact> contactList = await DatabaseHelper().getContactList();
//   if (contactList.isEmpty) {
//     Fluttertoast.showToast(msg: "no number exist please add a number");
//   } else {
//     for (var i = 0; i < contactList.length; i++) {
//       Telephony.backgroundInstance
//           .sendSms(to: contactList[i].number, message: messageBody)
//           .then((value) {
//         Fluttertoast.showToast(msg: "message send");
//       });
//     }
//   }
// }



Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "Public Saftey App",
    "foregrounf service",
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        notificationChannelId: "Public Safety App",
        initialNotificationTitle: "foregrounf service",
        initialNotificationContent: "initializing",
        foregroundServiceNotificationId: 888,
      ));
  service.startService();
}

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: 2), (timer) async {
    
    Position? _curentPosition;

    if (service is AndroidServiceInstance) 
    {
      if (await service.isForegroundService())
       {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                forceAndroidLocationManager: true)
            .then((Position position) 
            {
          _curentPosition = position;
          print("bg location ${position.latitude}");
        }).catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        });

        ShakeDetector.autoStart(
            shakeThresholdGravity: 7,
            shakeSlopTimeMS: 500,
            shakeCountResetTime: 3000,
            minimumShakeCount: 1,
            onPhoneShake: () async {
              if (await Vibration.hasVibrator() ?? false) {

                print("888");
                if(await Vibration.hasCustomVibrationsSupport() ?? false){
                  print("Test 5");
                  Vibration.vibrate(duration: 2000);
                  await Future.delayed(Duration(milliseconds: 500));
                  Vibration.vibrate();
                }
              }
              // String messageBody =
              //     "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}";
              // sendMessage(messageBody);
            });

        flutterLocalNotificationsPlugin.show(
          888,
          "Public Safety App",
          "shake feature enable",
          NotificationDetails(
              android: AndroidNotificationDetails(
            "Public Safety App",
            "foregrounf service",
            icon: 'ic_bg_service_small',
            ongoing: true,
          )),
        );
      }
    }
  });
}