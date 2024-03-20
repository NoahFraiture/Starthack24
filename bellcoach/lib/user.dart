class UserCustom {
  static String name = "Noah";
  static String email = "noah@noah";
  static int credits = 0;
  static bool connected = false;
  static Place place = Place.brussels;

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
}

enum Place { madrid, budapest, brussels }
