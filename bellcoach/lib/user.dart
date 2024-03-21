import 'dart:math';

import 'package:bellcoach/page/notifications.dart';

class UserCustom {
  static final People self = People(
      "Self",
      "assets/duolingo.png",
      Place.brussels,
      250,
      false,
      Language.french,
      "noah@noah.com",
      [],
      [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(20))],
      [Notification(People(
          "John Doe",
          "assets/duolingo.png",
          Place.brussels,
          150,
          true,
          Language.english,
          "john@doe.com",
          ["I am looking for help with programming"],
          [],
          []), DateTime.now().subtract(Duration(hours: 1)), "You have a new friend request", NotificationType.friendRequest),
        Notification(People(
            "Jane Smith",
            "assets/vic.png",
            Place.madrid,
            50,
            false,
            Language.french,
            "jane@smith.com",
            ["I love learning new languages"],
            [],
            []), DateTime.now().subtract(Duration(hours: 2)), "Objectives fulfilled", NotificationType.objectivesFulfilled),
        Notification(People(
            "Charlie Brown",
            "assets/dede.png",
            Place.budapest,
            300,
            true,
            Language.spanish,
            "charlie@brown.com",
            ["Need recommendations for books"],
            [],
            []), DateTime.now().subtract(Duration(hours: 3)), "New worker arrived in the area", NotificationType.newWorkerArrived)]);
  static bool connected = false;
  static Language language = self.language;
  static String name = self.name;
  static String email = self.email;
  static int credits = self.credits;
  static Place place = self.place;
  static List<ActivityData> activity = self.activity;
  static List<String> problems = self.problems;
  static List<Notification> notifications = self.notifications;
  static List<People> people = [
    self,
    People(
        "Bryce",
        "assets/duolingo.png",
        Place.madrid,
        0,
        true,
        Language.german,
        "bryce@noah.com",
        ["I lost my underwears, does anyone know how to get them back?", "I also lost my shoes"],
        [],[]),
    People("Victoria", "assets/duolingo.png", Place.brussels, 0, true, Language.french,
        "victoria@noah.com", [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor "
          "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud "
          "exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute "
          "irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia "
          "deserunt mollit anim id est laborum."
    ], [], []),
    People("Delphine", "assets/duolingo.png", Place.budapest, 0, true, Language.english,
        "delphine@noah.com", [], [],[]),
    People("Manu", "assets/duolingo.png", Place.brussels, 0, false, Language.french,
        "manu@noah.com", ["I'm hungry, does someone have a pizza ?"], [], []),
    People("Machin", "assets/duolingo.png", Place.brussels, 0, false, Language.german,
        "manu@noah.com", [], [],[]),
    People("machin", "assets/duolingo.png", Place.budapest, 0, false, Language.french,
        "manu@noah.com", [], [],[]),
  ];

  static void addSelfMessage(String message) {
    self.problems.add(message);
  }

  static final UserCustom _singleton = UserCustom._internal();
  UserCustom._internal();
  factory UserCustom() {
    return _singleton;
  }

  static String placeToString(Place place) {
    switch (place) {
      case Place.madrid:
        return "Madrid";
      case Place.budapest:
        return "Budapest";
      case Place.brussels:
        return "Brussels";
    }
  }

  static String languageToString(Language language) {
    switch (language) {
      case Language.english:
        return "English";
      case Language.french:
        return "French";
      case Language.spanish:
        return "Spanish";
      case Language.german:
        return "German";
    }
  }
}

enum Place { madrid, budapest, brussels }

enum Language { english, french, spanish, german }

class People {
  final Language language;
  final String email;
  bool isFriend;
  final String name;
  final String picturePath;
  final Place place;
  final int credits;
  List<String> problems;
  List<ActivityData> activity;
  List<Notification> notifications;

  People(this.name, this.picturePath, this.place, this.credits, this.isFriend, this.language,
      this.email, this.problems, this.activity, this.notifications);

  void addProblem(String problem) {
    problems.add(problem);
  }

  void addNotification(Notification notification) {
    notifications.add(notification);
  }

  void removeNotification(int index) {
    notifications.removeAt(index);
  }

}

class ActivityData {
  final DateTime date;
  final int value;

  ActivityData(this.date, this.value);
}
