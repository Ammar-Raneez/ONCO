class UserDetails {
  static Map _userData;

  // setter
  static void setUserData(String email, String username, String gender) {
    _userData = {"email": email, "username": username, "gender": gender};
    // print("---------------------------------------------------------");
    // print(_userData);
    // print("---------------------------------------------------------");
  }

  // getter
  static Map getUserData() {
    return _userData;
  }
}
