import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_router.dart';
import 'package:memo/core/services/notification_service.dart';
import 'package:memo/core/theme/theme.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/ai_chat/cubits/ai_chat_cubit.dart';
import 'package:memo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureInjection();
  FirebaseNotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppUtils.unfocusKeyboard(context);
      },

      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<AiChatCubit>()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme(context),
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}
