import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/timezone.dart'as tz;
import 'package:timezone/data/latest.dart' as tz ;

import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import '../model/taskmodel.dart';
import '../screen/notificationScreen.dart';

class NotifyHelper{
  // Creatintg and init the FlutterLocalNotificationsPlugin here
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); //
// init starts
  initializeNotification() async {
    _configureLocalTimezone();
  // tz.initializeTimeZones();

    // This one for Ios
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );



    // This one for android
    final  AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

      final InitializationSettings initializationSettings =
      InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to flutter"));
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }
  // here we calling the request for sending the notifications
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  Future  onDidReceiveNotificationResponse( payload) async {

    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    if(payload.payload =="Theme Changed"){

    }else{
      Get.to(()=>NotifyScreen(label: payload.payload,));
    }

  }
  displayNotification({required String title, required String body}) async {

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new DarwinNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }
  scheduledNotification(int hour,int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
      task.note,
        _convertTime(hour, minutes),
      //  tz.TZDateTime.now(tz.local).add( Duration(seconds: minutes)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${task.title}|"+"${task.note}|"+"${task.startTime}"


    );

  }
  tz.TZDateTime _convertTime(int hour ,int minuties){
    final tz.TZDateTime now=tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate= tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minuties);
    if(scheduleDate.isBefore(now)){
      scheduleDate= scheduleDate.add(const Duration(days: 1));
    }
return scheduleDate;
  }

 Future<void> _configureLocalTimezone()async{
    tz.initializeTimeZones();
    final String timeZone= await FlutterNativeTimezone.getLocalTimezone();

   tz.setLocalLocation( tz.getLocation(timeZone));
  }

}
