class UserCustom {
  static String name = "user";
  static int credits = 0;

  static final UserCustom _singleton = UserCustom._internal();
  UserCustom._internal();
  factory UserCustom() {
    return _singleton;
  }
}
