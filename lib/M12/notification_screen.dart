import 'dart:async';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int currentStep = 0;
  Timer? udpateNotificationAfter1Second;

  Future<void> showProgressNotification(int id) async {
    int maxStep = 10;
    int fragmentation = 4;
    for (
      var simulatedStep = 1;
      simulatedStep <= maxStep * fragmentation + 1;
      simulatedStep++
    ) {
      currentStep = simulatedStep;
      await Future.delayed(Duration(milliseconds: 1000 ~/ fragmentation));
      if (udpateNotificationAfter1Second != null) continue;
      udpateNotificationAfter1Second = Timer(const Duration(seconds: 1), () {
        _updateCurrentProgressBar(
          id: id,
          simulatedStep: currentStep,
          maxStep: maxStep * fragmentation,
        );
        udpateNotificationAfter1Second?.cancel();
        udpateNotificationAfter1Second = null;
      });
    }
  }

  void _updateCurrentProgressBar({
    required int id,
    required int simulatedStep,
    required int maxStep,
  }) {
    if (!(simulatedStep < maxStep)) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: 'Selesai',
          body: 'Progress sudah selesai',
          category: NotificationCategory.Progress,
          locked: false,
        ),
      );
    } else {
      int progress = min((simulatedStep / maxStep * 100).round(), 100);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: 'Progress Bar Notification',
          body: '$progress% Ini adalah Progress Bar Notification',
          category: NotificationCategory.Progress,
          notificationLayout: NotificationLayout.ProgressBar,
          progress: progress.toDouble(),
          locked: true,
        ),
      );
    }
  }

  void basic() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Normal Notification',
        body: 'Ini adalah normal notification',
      ),
    );
  }

  void image() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'basic_channel',
        title: 'Image Notification',
        body: 'Ini adalah image notification',
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/spongebob.png',
      ),
    );
  }

  void schedule() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 5,
        channelKey: 'basic_channel',
        title: 'Schedule Notification',
        body: 'Ini adalah schedule notification',
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(Duration(seconds: 5)),
        allowWhileIdle: true,
      ),
    );
  }

  void action() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 4,
        channelKey: 'basic_channel',
        title: 'Action Notification',
        body: 'Ini adalah action notification',
      ),
      actionButtons: [
        NotificationActionButton(key: 'lihat', label: "Lihat Sekarang"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Screen"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: basic,
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("Normal Notification"),
            ),
            TextButton(
              onPressed: image,
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("Image Notification"),
            ),
            TextButton(
              onPressed: () {
                showProgressNotification(5);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("Progress Notification"),
            ),
            TextButton(
              onPressed: action,
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("Action Button Notification"),
            ),
            TextButton(
              onPressed: schedule,
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("Schedule Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
