import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class GameAnswerInput extends StatefulWidget {
  const GameAnswerInput({
    super.key,
    required this.controller,
    required this.onSubmit,
    this.isSubmitted = false,
    this.submittedAnswer,
    this.maxLength = 150,
    this.hintText = 'Type your answer...',
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final bool isSubmitted;
  final String? submittedAnswer;
  final int maxLength;
  final String hintText;

  @override
  State<GameAnswerInput> createState() => _GameAnswerInputState();
}

class _GameAnswerInputState extends State<GameAnswerInput>
    with SingleTickerProviderStateMixin {
  late final AnimationController _submitController;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _submitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant GameAnswerInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSubmitted && !oldWidget.isSubmitted) {
      _submitController.forward();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _submitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSubmitted) {
      return _buildSubmittedState();
    }
    return _buildInputState();
  }

  Widget _buildSubmittedState() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.elasticOut,
      builder: (_, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.chipGreenBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.statusGreen.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.statusGreen.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.statusGreen,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Answer submitted!',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.chipGreenText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Waiting for partner...',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 12,
                      color: AppColors.textCaption,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.hourglass_top_rounded,
              color: AppColors.statusOrange.withOpacity(0.7),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputState() {
    final charCount = widget.controller.text.length;
    final isNearLimit = charCount > widget.maxLength * 0.8;
    final canSubmit = charCount > 0 && charCount <= widget.maxLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isFocused
                    ? AppColors.primary.withOpacity(0.6)
                    : AppColors.border.withOpacity(0.5),
                width: _isFocused ? 2 : 1.5,
              ),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: AppColors.shadow.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: TextField(
              controller: widget.controller,
              maxLength: widget.maxLength,
              maxLines: 3,
              minLines: 2,
              textCapitalization: TextCapitalization.sentences,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 16,
                color: AppColors.textDark,
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.rubik.copyWith(
                  fontSize: 15,
                  color: AppColors.textGrey,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                counterText: '',
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.rubik.copyWith(
                fontSize: 12,
                fontWeight: isNearLimit ? FontWeight.w600 : FontWeight.normal,
                color: isNearLimit
                    ? AppColors.statusOrange
                    : AppColors.textGrey,
              ),
              child: Text('$charCount / ${widget.maxLength}'),
            ),
            const Spacer(),
            AnimatedScale(
              scale: canSubmit ? 1.0 : 0.85,
              duration: const Duration(milliseconds: 200),
              child: AnimatedOpacity(
                opacity: canSubmit ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 200),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: canSubmit ? widget.onSubmit : null,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: canSubmit
                            ? const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.buttonPrimary,
                                ],
                              )
                            : null,
                        color: canSubmit ? null : AppColors.softGrey,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: canSubmit
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Submit',
                            style: AppTextStyles.rubik.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: canSubmit
                                  ? AppColors.white
                                  : AppColors.textGrey,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.send_rounded,
                            size: 16,
                            color: canSubmit
                                ? AppColors.white
                                : AppColors.textGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
