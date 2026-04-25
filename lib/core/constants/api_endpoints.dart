class ApiEndpoints {
  static const String healthCheck = "/healthcheck";

  // user

  static const String user = "/user";

  // auth
  static const String register = "/register";
  static const String verifyToken = "/activate";
  static const String resendToken = "/resendOtp";
  static const String login = "/login";
  static const String googleLogin = "/google-login";

  // premium
  static const String changePremium = "/premium";

  // forget password
  static const String requestToken = "/forget-password/otp";
  static const String verifyForgetToken = "/forget-password/verify";
  static const String resetPassword = "/forget-password/changePassword";

  // connections

  static const String listConnections = "/connections";
  static const String sendRequest = "/connection-request";
  static const String listReceivedConnections = "/connection-requests/received";
  static const String listSentConnections = "/connection-requests/sent";
}
