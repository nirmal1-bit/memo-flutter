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

  // task
  static const String scanDocument = "/scanTask";
  static const String addTask = "/createTask";
  static const String listTasks = "/listTask";
  static String updateTask(int id) => "/updateTask/$id";
  static String deleteTask(int id) => "/deleteTask/$id";
  static String toggleComplete(int id) => "/toogleComplete/$id";
  static const String deleteCompleted = "/completed";
  static const String listPendingTasks = "/listPendingTask";

  // habits
  static const String addHabit = "/createHabit";
  static const String listHabits = "/listHabits";
  static String editHabit(int id) => "/updateHabit/$id";
  static String deleteHabit(int id) => "/deleteHabit/$id";

  //habit logs
  static String createHabitLogs = "/createHabitLog";
  static String getHabitLogs = "/listHabitLogs";
  static String deleteHabitLogs = "/deleteHabitLog";

  // stats
  static const String stats = "/stats";

  // notes
  static const String scanNote = "/scanNote";
  static const String addNote = "/createNote";
  static const String listNotes = "/listNotes";
  static String editNote(int id) => "/updateNote/$id";
  static String deleteNote(int id) => "/deleteNote/$id";
  static const String listNotesTitle = "/sameTitle";
}
