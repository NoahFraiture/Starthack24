class UserCustom {
  static Language language = Language.english;
  static String name = "Noah";
  static String email = "noah@noah";
  static int credits = 0;
  static bool connected = false;
  static Place place = Place.brussels;
  static List<People> friends = const [
    People("Noah", "assets/duolingo.png", Place.brussels, 0, true, Language.english),
    People("Hannah", "assets/duolingo.png", Place.madrid, 0, true, Language.english),
    People("Sarah", "assets/duolingo.png", Place.budapest, 0, true, Language.english),
  ];

  static List<People> people = const [
    People("Noah", "assets/duolingo.png", Place.brussels, 0, false, Language.english),
    People("Hannah", "assets/duolingo.png", Place.madrid, 0, false, Language.french),
    People("Sarah", "assets/duolingo.png", Place.budapest, 0, false, Language.english),
  ];

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
    }
  }
}

class People {
  final Language language;
  final bool isFriend;
  final String name;
  final String picturePath;
  final Place place;
  final int credits;

  const People(this.name, this.picturePath, this.place, this.credits, this.isFriend, this.language);
}

enum Place { madrid, budapest, brussels }

enum Language { english, french, spanish }
