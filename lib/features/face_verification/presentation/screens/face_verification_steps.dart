import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/face_verification/cubit/image_capture_cubit.dart';
import 'package:memo/features/face_verification/cubit/verify_face_cubit.dart';
import 'package:memo/features/face_verification/data/face_verify_response.dart';
import 'package:memo/features/face_verification/presentation/screens/face_verification_screen.dart';
import 'package:memo/features/face_verification/presentation/screens/widgets/step_content.dart';

class VerificationSteps extends StatefulWidget {
  final List<Widget> screens;

  const VerificationSteps({super.key, required this.screens});

  @override
  State<VerificationSteps> createState() => _VerificationStepsState();
}

class _VerificationStepsState extends State<VerificationSteps> {
  int _activeStep = 0;
  bool _forward = true; // tracks direction for the transition

  bool get _isLast => _activeStep == 5;

  void _goToNext() {
    if (_isLast) return;
    setState(() {
      _forward = true;
      _activeStep++;
    });
  }

  void checkIfThisStepCompleted(BuildContext context) {
    final state = context.read<ImageCaptureCubit>().state;
    if (state.image == null) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: "Please Complete this step before proceeding to next.",
      );
      return;
    }
    context.read<VerifyFaceCubit>().verifyFace(state.image!);

    _goToNext();
  }

  void _goToPrev() {
    if (_activeStep == 0) return;
    setState(() {
      _forward = false;
      _activeStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ImageCaptureCubit>()),
        BlocProvider(create: (_) => getIt<VerifyFaceCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<VerifyFaceCubit, BaseApiState<FaceVerifyResponse>>(
            listener: (context, state) async {
              state.maybeWhen(
                success: (data) async {
                  if (data.verified == true) {
                    AppUtils.showSuccessSnackbar(
                      context: context,
                      message: 'Face verification successful',
                    );
                    setState(() {
                      _activeStep = 5;
                    });
                  } else {
                    AppUtils.showErrorSnackbar(
                      context: context,
                      message:
                          'We could not verify your face. Please try again.',
                    );
                  }
                },
                error: (message) {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: message,
                  );
                },
                validationError: (validationError) {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: validationError.message,
                  );
                },
                noInternet: () {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: 'No internet connection',
                  );
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.scaffoldBackground,

              body: SafeArea(
                child: Column(
                  children: [
                    // ── Stepper bar ──────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 30,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: EasyStepper(
                          steppingEnabled: false,
                          activeStep: _activeStep,
                          direction: Axis.horizontal,
                          showTitle: true,
                          stepRadius: 24,
                          finishedStepBackgroundColor: AppColors.primary,
                          activeStepBackgroundColor: AppColors.primary,
                          lineStyle: const LineStyle(
                            lineType: LineType.dotted,
                            unreachedLineType: LineType.dashed,
                          ),
                          steps: const [
                            EasyStep(
                              icon: Icon(Icons.privacy_tip),
                              title: 'Privacy',
                            ),

                            EasyStep(
                              icon: Icon(Icons.info_outline_rounded),
                              title: 'Intro',
                            ),
                            EasyStep(
                              icon: Icon(Icons.camera_alt_rounded),
                              title: 'Capture',
                            ),
                            EasyStep(
                              icon: Icon(Icons.camera_alt_rounded),
                              title: 'Capture',
                            ),

                            EasyStep(
                              icon: Icon(Icons.face_retouching_natural),
                              title: 'Review',
                            ),
                            EasyStep(
                              icon: Icon(Icons.verified_rounded),
                              title: 'Done',
                            ),
                          ],
                          onStepReached: (index) =>
                              setState(() => _activeStep = index),
                        ),
                      ),
                    ),

                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder: (child, animation) {
                          final offsetTween = Tween<Offset>(
                            begin: Offset(_forward ? 0.15 : -0.15, 0),
                            end: Offset.zero,
                          );
                          return ClipRect(
                            child: SlideTransition(
                              position: offsetTween.animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            ),
                          );
                        },
                        layoutBuilder: (currentChild, previousChildren) =>
                            Stack(
                              alignment: Alignment.center,
                              children: [...previousChildren, ?currentChild],
                            ),
                        child: KeyedSubtree(
                          key: ValueKey(_activeStep),
                          child: _activeStep == 3
                              ? FaceVerificationScreen(
                                  onImageCaptured: (file) {
                                    setState(() {
                                      _activeStep++;
                                    });
                                    context.read<VerifyFaceCubit>().verifyFace(
                                      file,
                                    );
                                  },
                                )
                              : StepContent(stepIndex: _activeStep),
                        ),
                      ),
                    ),

                    BlocBuilder<
                      VerifyFaceCubit,
                      BaseApiState<FaceVerifyResponse>
                    >(
                      builder: (context, state) {
                        var data = state.maybeWhen(
                          orElse: () => FaceVerifyResponse(
                            similarity: 0.0,
                            verified: false,
                          ),
                          success: (data) => data,
                        );

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 40,
                          ),
                          child: Row(
                            children: [
                              if (_activeStep > 0) ...[
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: _goToPrev,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.primary,
                                      side: const BorderSide(
                                        color: AppColors.primary,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'Back',
                                      style: AppTextStyles.rubik.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                              if (!(!data.verified && _activeStep == 4))
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_isLast) {
                                        context.replace(AppRoutes.main);
                                      } else if (_activeStep == 3) {
                                        checkIfThisStepCompleted(context);
                                      } else {
                                        _goToNext();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isLast
                                          ? AppColors.statusGreen
                                          : AppColors.primary,
                                      foregroundColor: AppColors.white,
                                      disabledBackgroundColor:
                                          AppColors.statusGreen,
                                      disabledForegroundColor: AppColors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _isLast ? 'All Done' : 'Continue',
                                          style: AppTextStyles.rubik.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Icon(
                                          _isLast
                                              ? Icons
                                                    .check_circle_outline_rounded
                                              : Icons.arrow_forward_rounded,
                                          size: 18,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
