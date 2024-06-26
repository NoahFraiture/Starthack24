import 'dart:math';
import 'package:bellcoach/page/notifications.dart';

class UserCustom {
  // sport information
  static SportCategory sportCategory = SportCategory.muscle;

  static String sportCategoryToString(SportCategory sportCategory) {
    switch (sportCategory) {
      case SportCategory.muscle:
        return "Muscle";
      case SportCategory.cardio:
        return "Cardio";
    }
  }

  static List<SportData> sportData = [];
  static void addSportData(SportData sportData) {
    UserCustom.sportData.add(sportData);
  }

  // data
  static DateTime lastAwake = DateTime.now();
  static List<Sleep> sleeps = [Sleep(DateTime.now(), const Duration(hours: 7))];
  static void addSleep(Sleep sleep) {
    sleeps.add(sleep);
    people[0] = self;
  }

  // Last date you walked to reset your steps every day
  static DateTime lastDayWalked = DateTime.now();
  static int currentSteps = 0;
  static List<Walk> walks = [];
  static void addWalk(Walk walk) {
    walks.add(walk);
    people[0] = self;
  }

  // Water drinking
  static int water = 0;

  // green wall
  static List<ActivityData> activity = self.activity;

  // message on the public wall
  static List<String> problems = self.problems;
  static void addSelfMessage(String message) {
    self.problems.add(message);
    self.name = name;
    people[0] = self;
  }

  // coach
  static String coach() {
    return self.getCoachPath();
  }

  // informations
  static final People self = People(
      "Noah",
      "assets/noah.png",
      Place.brussels,
      500,
      false,
      Language.french,
      "noah@noah.com",
      [],
      [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(9))],
      [
        Notification(
            People(
                "Manu",
                "assets/manu.png",
                Place.brussels,
                150,
                true,
                Language.english,
                "john@doe.com",
                ["I am looking for help with programming"],
                [],
                [],
                [],
                [],
                Gender.boy),
            DateTime.now().subtract(const Duration(hours: 1)),
            "You have a new friend request",
            NotificationType.friendRequest),
        Notification(
            People(
                "Victoria Van Rillaer",
                "assets/vic.png",
                Place.madrid,
                50,
                false,
                Language.french,
                "jane@smith.com",
                ["I love learning new languages"],
                [],
                [],
                [],
                [],
                Gender.girl),
            DateTime.now().subtract(const Duration(hours: 2)),
            "Objectives fulfilled",
            NotificationType.objectivesFulfilled),
        Notification(
            People(
                "Delphine van Rossum",
                "assets/dede.png",
                Place.budapest,
                300,
                true,
                Language.spanish,
                "charlie@brown.com",
                ["Need recommendations for books"],
                [],
                [],
                [],
                [],
                Gender.girl),
            DateTime.now().subtract(const Duration(hours: 3)),
            "New worker arrived in the "
            "area",
            NotificationType.newWorkerArrived)
      ],
      [],
      [],
      Gender.girl);

  static bool connected = false;
  static Language language = self.language;
  static String name = self.name;
  static String email = self.email;
  static int credits = self.credits;
  static Place place = self.place;
  static List<Notification> notifications = self.notifications;
  static Gender coachGender = self.coachGender; // 1 or 2
  static int coachLvl = self.coachLvl; // 1 to 3
  static String coachPath = self.getCoachPath();
  static String coachIconPath = self.getCoachIconPath();

  static List<People> people = [
    self,
    People(
        "Bryceuh",
        "assets/bryce.png",
        Place.madrid,
        0,
        true,
        Language.german,
        "bryce@noah.com",
        ["I lost my stuffs, does anyone know how to get them back?", "I also lost my badge"],
        [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(9))],
        [],
        [],
        [],
        Gender.boy),
    People(
        "Victoria",
        "assets/vic.png",
        Place.brussels,
        0,
        true,
        Language.french,
        "victoria@noah.com",
        [
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor "
              "incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud "
              "exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute "
              "irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
              "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia "
              "deserunt mollit anim id est laborum."
        ],
        [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(9))],
        [],
        [],
        [],
        Gender.girl),
    People(
        "Delphine",
        "assets/dede.png",
        Place.budapest,
        0,
        true,
        Language.english,
        "delphine@noah.com",
        [],
        [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(9))],
        [],
        [],
        [],
        Gender.girl),
    People(
        "Manu",
        "assets/manu.png",
        Place.brussels,
        0,
        false,
        Language.french,
        "manu@noah.com",
        ["I'm hungry, does someone have a pizza ?"],
        [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(9))],
        [],
        [],
        [],
        Gender.boy),
    People(
        "Machin",
        "assets/dede.png",
        Place.brussels,
        0,
        false,
        Language.german,
        "manu@noah.com",
        [],
        [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(9))],
        [],
        [],
        [],
        Gender.girl),
    People(
        "machin",
        "assets/noah.png",
        Place.budapest,
        0,
        false,
        Language.french,
        "manu@noah.com",
        [],
        [for (int i = 0; i < 7 * 8; i++) ActivityData(DateTime.now(), Random().nextInt(9))],
        [],
        [],
        [],
        Gender.boy),
  ];
  static List<String> earnedBadges = ["Walking 21 days", "No sugar", "Sleep", "Meditation"];
  static List<String> achievedGoals = self.achievedGoals;

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

  static String getCoachPath() {
    return self.getCoachPath();
  }

  static String getCoachIconPath() {
    return self.getCoachIconPath();
  }
}

class Walk {
  final DateTime date;
  final int steps;

  Walk(this.date, this.steps);
}

class Sleep {
  final DateTime date;
  final Duration duration;

  Sleep(this.date, this.duration);
}

enum Place { madrid, budapest, brussels }

enum Language { english, french, spanish, german }

enum Gender { boy, girl }

enum Integer { a, b, c, d, e, f, g, h }

class People {
  final Language language;
  final String email;
  bool isFriend;
  String name;
  final String picturePath;
  final Place place;
  int credits;
  List<String> problems;
  List<ActivityData> activity;
  List<Notification> notifications;
  List<String> achievedGoals;
  List<String> earnedBadges;
  Gender coachGender; // 1 or 2
  int coachLvl = 1; // 1 to 3

  People(
      this.name,
      this.picturePath,
      this.place,
      this.credits,
      this.isFriend,
      this.language,
      this.email,
      this.problems,
      this.activity,
      this.notifications,
      this.achievedGoals,
      this.earnedBadges,
      this.coachGender);

  void addProblem(String problem) {
    problems.add(problem);
  }

  void addNotification(Notification notification) {
    notifications.add(notification);
  }

  void removeNotification(int index) {
    notifications.removeAt(index);
  }

  void addAchievedGoal(String goal) {
    achievedGoals.add(goal);
  }

  void addEarnedBadge(String badge) {
    earnedBadges.add(badge);
  }

  String getCoachPath() {
    if (coachGender == Gender.boy) {
      return "assets/Coach1-$coachLvl.gif";
    }
    return "assets/Coach2-$coachLvl.gif";
  }

  String getCoachIconPath() {
    if (coachGender == Gender.boy) {
      return "assets/Icone_coach1-$coachLvl.gif";
    }
    return "assets/Icone_coach2-$coachLvl.gif";
  }
}

class ActivityData {
  final DateTime date;
  final int value;

  ActivityData(this.date, this.value);
}

enum SportCategory {
  muscle,
  cardio,
}

class Exercice {
  final String picturePath;
  final Duration duration;
  final SportCategory category;
  final String name;

  const Exercice(
      {required this.picturePath,
      required this.duration,
      required this.category,
      required this.name});
}

class SportData {
  final Exercice exercice;
  final DateTime dateTime;

  SportData(this.exercice, this.dateTime);
}
