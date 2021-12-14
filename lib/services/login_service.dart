class LoginService {
  Future<bool> loginWithUsernameAndPassword(
      String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(true);
  }
}
