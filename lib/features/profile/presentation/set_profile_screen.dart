import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/constants/cloudinary_constants.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:memo/features/common/form_widgets.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';
import 'package:memo/features/profile/presentation/cubits/edit_profile_cubit.dart';
import 'package:memo/features/profile/presentation/cubits/set_profile_cubit.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key, this.initialProfile});

  final ProfileRequestModel? initialProfile;

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _headlineController = TextEditingController();
  final _bioController = TextEditingController();
  final _profileUrlController = TextEditingController();
  final _websiteController = TextEditingController();
  final _locationController = TextEditingController();
  final _companyController = TextEditingController();

  String _avatarUrl = '';
  bool _isUploadingAvatar = false;
  bool _prefilled = false;

  void _applyInitialProfile(ProfileRequestModel? profile) {
    if (profile == null || _prefilled) {
      return;
    }

    _headlineController.text = profile.headline;
    _bioController.text = profile.bio;
    _profileUrlController.text = profile.profileUrl;
    _websiteController.text = profile.website;
    _locationController.text = profile.location;
    _companyController.text = profile.companyName;
    _avatarUrl = profile.avatarUrl;
    _prefilled = true;
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _bioController.dispose();
    _profileUrlController.dispose();
    _websiteController.dispose();
    _locationController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    if (_isUploadingAvatar) {
      return;
    }

    final pickedFile = await AppUtils.pickImage();
    if (pickedFile == null) {
      return;
    }

    setState(() {
      _isUploadingAvatar = true;
    });

    try {
      final uploadedUrl = await AppUtils.uploadImage(
        file: pickedFile,
        folder: CloudinaryConstants.profileFolder,
      );

      if (!mounted) {
        return;
      }

      if (uploadedUrl == null || uploadedUrl.isEmpty) {
        AppUtils.showErrorSnackbar(
          context: context,
          message: 'Image upload failed. Try again.',
        );
        return;
      }

      setState(() {
        _avatarUrl = uploadedUrl;
      });

      AppUtils.showSuccessSnackbar(
        context: context,
        message: 'Avatar uploaded successfully',
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      AppUtils.showErrorSnackbar(context: context, message: error.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isUploadingAvatar = false;
        });
      }
    }
  }

  void _submitProfile(BuildContext context) {
    if (_avatarUrl.isEmpty) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: 'Upload a profile image first.',
      );
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<SetProfileCubit>().setupProfile(
      ProfileRequestModel(
        headline: _headlineController.text.trim(),
        bio: _bioController.text.trim(),
        profileUrl: _profileUrlController.text.trim(),
        avatarUrl: _avatarUrl,
        website: _websiteController.text.trim(),
        location: _locationController.text.trim(),
        companyName: _companyController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              EditProfileCubit()..setInitialProfile(widget.initialProfile),
        ),
        BlocProvider(create: (_) => getIt<SetProfileCubit>()),
      ],
      child: BlocListener<SetProfileCubit, BaseApiState<String>>(
        listener: (context, state) {
          state.maybeWhen(
            success: (_) {
              AppUtils.showSuccessSnackbar(
                context: context,
                message: 'Profile saved successfully',
              );

              if (context.canPop()) {
                context.pop();
                return;
              }

              context.go(AppRoutes.userProfile);
            },
            error: (message) {
              AppUtils.showErrorSnackbar(context: context, message: message);
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
        child: Builder(
          builder: (context) {
            return BlocBuilder<EditProfileCubit, ProfileRequestModel?>(
              builder: (context, initialProfile) {
                _applyInitialProfile(initialProfile);

                return BlocBuilder<SetProfileCubit, BaseApiState<String>>(
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );

                    return Scaffold(
                      backgroundColor: AppColors.scaffoldBackground,
                      appBar: AppBar(
                        backgroundColor: AppColors.scaffoldBackground,
                        elevation: 0,
                        foregroundColor: AppColors.softPrimary,
                        title: Text(
                          initialProfile == null
                              ? 'Set up profile'
                              : 'Edit profile',
                          style: AppTextStyles.libre.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.softPrimary,
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: AppColors.dividerColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.softBlack.withOpacity(
                                        0.05,
                                      ),
                                      blurRadius: 18,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: _pickAvatar,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 116,
                                            height: 116,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  AppColors.primary,
                                                  AppColors.primary.withValues(
                                                    alpha: 0.72,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: ClipOval(
                                                child: _avatarUrl.isNotEmpty
                                                    ? Image.network(
                                                        _avatarUrl,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              _,
                                                              __,
                                                              ___,
                                                            ) => _AvatarPlaceholder(
                                                              isUploading:
                                                                  _isUploadingAvatar,
                                                            ),
                                                      )
                                                    : _AvatarPlaceholder(
                                                        isUploading:
                                                            _isUploadingAvatar,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          if (_isUploadingAvatar)
                                            Container(
                                              width: 116,
                                              height: 116,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.black
                                                    .withOpacity(0.35),
                                              ),
                                              child: const Center(
                                                child: SizedBox(
                                                  width: 26,
                                                  height: 26,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2.4,
                                                        color: AppColors.white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      _avatarUrl.isEmpty
                                          ? 'Tap to upload an avatar'
                                          : 'Avatar uploaded',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.rubik.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.softPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Images are uploaded to Cloudinary before the profile is saved.',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.rubik.copyWith(
                                        fontSize: 12.5,
                                        color: AppColors.softTextGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              InputField(
                                controller: _headlineController,
                                label: 'Headline',
                                hint:
                                    'Mobile App Developer | Flutter Enthusiast',
                                icon: Icons.work_outline_rounded,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter your headline'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                controller: _bioController,
                                label: 'Bio',
                                hint: 'Tell people what you are building',
                                icon: Icons.notes_outlined,
                                maxLines: 4,
                                keyboardType: TextInputType.multiline,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter your bio'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                controller: _profileUrlController,
                                label: 'Profile URL',
                                hint: 'https://example.com/janesmith',
                                icon: Icons.link_rounded,
                                keyboardType: TextInputType.url,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter your profile URL'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                controller: _websiteController,
                                label: 'Website',
                                hint: 'https://janesmith.dev',
                                icon: Icons.language_rounded,
                                keyboardType: TextInputType.url,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter your website'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                controller: _locationController,
                                label: 'Location',
                                hint: 'Pokhara, Nepal',
                                icon: Icons.location_on_outlined,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter your location'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                controller: _companyController,
                                label: 'Company',
                                hint: 'Innovate Labs',
                                icon: Icons.apartment_outlined,
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                    ? 'Enter your company name'
                                    : null,
                              ),
                              const SizedBox(height: 24),
                              AuthPrimaryButton(
                                label: 'Save profile',
                                isLoading: isLoading,
                                onPressed: () => _submitProfile(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder({required this.isUploading});

  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.brandBackground,
      child: Center(
        child: isUploading
            ? const SizedBox.shrink()
            : Icon(
                Icons.camera_alt_outlined,
                color: AppColors.primary.withOpacity(0.8),
                size: 34,
              ),
      ),
    );
  }
}
