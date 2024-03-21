import 'package:bellcoach/user.dart';
import 'package:flutter/material.dart';

import '../ressources/colors.dart';
import '../widget/top_bar_custom.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key? key}) : super(key: key);

  @override
  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(),
      body: ListView.builder(
        itemCount: UserCustom.self.notifications.length,
        itemBuilder: (context, index) {
          Notification notification = UserCustom.self.notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Card(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.asset(notification.sender.picturePath), // PicturePath from the sender
                  title: Text(notification.sender.name, // Sender's name
                      style: TextStyle(color: primaryFgColor)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(notification.message, style: TextStyle(color: primaryFgColor)),
                      Text('Received at: ${notification.notificationTime}', style: TextStyle(color: primaryFgColor)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: primaryFgColor),
                    onPressed: () {
                      setState(() {
                        UserCustom.self.removeNotification(index);
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
class Notification {
  final People sender;
  final DateTime notificationTime;
  final String message;
  final NotificationType type;

  Notification(this.sender, this.notificationTime, this.message, this.type);
}

enum NotificationType {
  giftReceived,
  newWorkerArrived,
  objectivesFulfilled,
  friendRequest,
  //... add more types as needed
}