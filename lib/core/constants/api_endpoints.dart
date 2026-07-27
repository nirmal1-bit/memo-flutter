class ApiEndpoints {
  static const String healthCheck = "/healthcheck";

  // user
  static const String user = "/user";
  static const String searchUser = "/users/search";

  //setprofile
  static const String setupProfile = "/user/profile";

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
  static const String sendRequest = "/connection-requests";
  static String connectionRequest(int id) => "/connection-requests/$id";
  static const String listReceivedConnections = "/connection-requests/received";
  static const String listSentConnections = "/connection-requests/sent";

  // video call
  static String agora(int id) => "connections/$id/agora-token";
  static String startCall(int id) => "connections/$id/video-call/start";
  static String endCall(int id) => "connections/$id/video-call/end";
  static String makeTranscript(int id) => "connections/$id/transcript";

  // fcm tokens
  static const String fcmToken = "/user/device";

  // connections
  static String memories(int id) => "/memories/$id";
  static String createMemory = "/memories";

  // timeline
  static String timeline(int id) => "/timeline/$id";

  // matches
  static const String matches = "/matches";

  //notification
  static const String notifications = "/notifications";

  //face

  static const String verifyFace = "/face/verify";
  static const String createFace = "/face/create";
  static const String getFaces = "/face/get-similar";
}
