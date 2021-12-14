class LoginService {
  Future<bool> loginWithUsernameAndPassword(
      String username, String password) async {
    await Future.delayed(Duration(2));
    return Future.value(true);
  }
}
