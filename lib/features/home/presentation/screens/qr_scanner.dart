import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/home/presentation/cubits/connection_action_cubit.dart';
import 'package:memo/features/home/presentation/widgets/connections/connections_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  bool _isProcessing = false;

  Future<void> _handleQr(String value, BuildContext context) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    context.read<ConnectionActionCubit>().sendConnectionRequest(
      int.tryParse(value) ?? 0,
    );
  }

  void _onDetect(BarcodeCapture capture, BuildContext context) {
    if (_isProcessing) return;

    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;

    if (value == null) return;

    _handleQr(value, context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<ConnectionActionCubit>())],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ConnectionActionCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (message) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: "Connection request sent successfully",
                  );
                  context.pop();
                },
                error: (message) async {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: "The provided QR is not a valid",
                  );

                  Future.delayed(
                    const Duration(seconds: 3),
                    () => setState(() => _isProcessing = false),
                  );
                },
                validationError: (validationError) {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: validationError.message,
                  );

                  Future.delayed(
                    const Duration(seconds: 3),
                    () => setState(() => _isProcessing = false),
                  );
                },
                noInternet: () {
                  AppUtils.showErrorSnackbar(
                    context: context,
                    message: 'No internet connection',
                  );

                  Future.delayed(
                    const Duration(seconds: 3),
                    () => setState(() => _isProcessing = false),
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
              body: Stack(
                children: [
                  MobileScanner(
                    onDetect: (capture) => _onDetect(capture, context),
                  ),
                  const ScannerOverlay(),
                  Positioned(
                    top: 50,
                    left: 16,
                    child: SafeArea(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
