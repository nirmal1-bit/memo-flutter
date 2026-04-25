import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_router.dart';
import 'package:memo/core/theme/theme.dart';
import 'package:memo/core/utils/app_utils.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
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
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme(context),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
