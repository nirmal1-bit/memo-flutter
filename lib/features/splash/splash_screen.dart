import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/features/common/animated_band_mark.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkSessionAndNavigate(),
    );
  }

  Future<void> _checkSessionAndNavigate() async {
    final sessionService = SessionService();
    final hasSession = await sessionService.hasSession;
    if (hasSession) {
      if (!mounted) return;

      context.replace(AppRoutes.main);
    } else if (!hasSession) {
      if (!mounted) return;
      context.replace(AppRoutes.authMain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: AnimatedBandMark()));
  }
}
