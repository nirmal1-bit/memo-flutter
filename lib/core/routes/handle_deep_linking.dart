import 'package:memo/core/routes/app_router.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/features/game/presentation/think_alike_screen_patner.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';

class HandleDeepLinking {
  static void pushToGame(Map<String, dynamic> data) {
    AppRouter.router.push(
      AppRoutes.thinkAlikePartner,
      extra: ThinkAlikePartnerArgs(
        user: Profile(
          id: 0,
          userId: 0,
          headline: "",
          bio: "",
          profileUrl: '',
          location: "",
          age: 0,
          gender: "",
          interests: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        sessionId: int.tryParse(data['session_id']) ?? 0,
        initiatorName: data['name'] as String,
        initiatorProfileUrl: data['profileUrl'] as String,
      ),
    );
  }
}
