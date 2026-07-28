import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo/core/utils/ui_helper.dart';
import 'package:memo/features/face_verification/cubit/create_face_cubit.dart';
import 'package:memo/features/face_verification/service/face_check_service.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
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

const List<String> _genderOptions = ['Male', 'Female'];

const List<String> _baseInterestOptions = [
  'Technology',
  'Sports',
  'Music',
  'Travel',
  'Reading',
  'Gaming',
  'Cooking',
  'Photography',
  'Art',
  'Fitness',
];

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
  final _locationController = TextEditingController();
  final _ageController = TextEditingController();
  final _customInterestController = TextEditingController();

  bool _isUploadingAvatar = false;
  String _avatarUrl = '';

  String? _selectedGender;

  final MultiSelectController<String> _interestsController =
      MultiSelectController<String>();
  late List<DropdownItem<String>> _interestItems;

  @override
  void initState() {
    super.initState();

    _interestItems = _baseInterestOptions
        .map(
          (interest) => DropdownItem<String>(label: interest, value: interest),
        )
        .toList();

    _applyInitialProfile(widget.initialProfile);
  }

  void _applyInitialProfile(ProfileRequestModel? profile) {
    if (profile == null) {
      return;
    }
    _avatarUrl = profile.profileUrl;
    _headlineController.text = profile.headline;
    _bioController.text = profile.bio;
    _locationController.text = profile.location;
    _ageController.text = profile.age.toString();

    // Gender
    final matchedGender = _genderOptions.where(
      (g) => g.toLowerCase() == profile.gender.toLowerCase(),
    );
    if (matchedGender.isNotEmpty) {
      _selectedGender = matchedGender.first;
    }

    // Interests — add any saved interests that aren't in the base
    // list, then select all that match once items are built.
    for (final interest in profile.interests) {
      final trimmed = interest.trim();
      if (trimmed.isEmpty) {
        continue;
      }

      final exists = _interestItems.any(
        (item) => item.value.toLowerCase() == trimmed.toLowerCase(),
      );
      if (!exists) {
        _interestItems.add(DropdownItem(label: trimmed, value: trimmed));
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _interestsController.selectWhere(
        (item) => profile.interests
            .map((e) => e.trim().toLowerCase())
            .contains(item.value.toLowerCase()),
      );
    });
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _ageController.dispose();
    _customInterestController.dispose();
    super.dispose();
  }

  XFile? pickedFile;
  Future<void> _pickAvatar(BuildContext context) async {
    if (_isUploadingAvatar) {
      return;
    }

    Uihelper.showloaderdialog(context);
    pickedFile = await AppUtils.pickImage();
    if (pickedFile == null) {
      return;
    }

    setState(() {
      _isUploadingAvatar = true;
    });

    try {
      final hasClearFace = await checkImageHasClearFace(
        File(pickedFile?.path ?? ''),
      );

      if (!mounted) {
        return;
      }
      Uihelper.hideloader(context);

      if (hasClearFace.hasClearFace == false) {
        AppUtils.showErrorSnackbar(
          context: context,
          message: hasClearFace.message,
        );
        return;
      }

      final uploadedUrl = await AppUtils.uploadImage(
        file: pickedFile ?? XFile(''),
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

  void _addCustomInterest() {
    final value = _customInterestController.text.trim();
    if (value.isEmpty) {
      return;
    }

    final existing = _interestItems.where(
      (item) => item.value.toLowerCase() == value.toLowerCase(),
    );

    if (existing.isEmpty) {
      final newItem = DropdownItem<String>(label: value, value: value);
      setState(() {
        _interestItems.add(newItem);
      });
      _interestsController.addItem(newItem);
      _interestsController.selectWhere((item) => item.value == value);
    } else {
      _interestsController.selectWhere(
        (item) => item.value.toLowerCase() == value.toLowerCase(),
      );
    }

    _customInterestController.clear();
    FocusScope.of(context).unfocus();
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

    if (_selectedGender == null) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: 'Select your gender.',
      );
      return;
    }

    final selectedInterests = _interestsController.selectedItems
        .map((item) => item.value)
        .toList();

    if (selectedInterests.isEmpty) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: 'Select at least one interest.',
      );
      return;
    }

    context.read<CreateFaceCubit>().createEmbedding(
      File(pickedFile?.path ?? ''),
    );

    if (widget.initialProfile != null) {
      context.read<EditProfileCubit>().editProfile(
        ProfileRequestModel(
          headline: _headlineController.text.trim(),
          bio: _bioController.text.trim(),
          profileUrl: _avatarUrl,
          location: _locationController.text.trim(),
          gender: _selectedGender!,
          age: int.tryParse(_ageController.text.trim()) ?? 0,
          interests: selectedInterests,
        ),
      );
      return;
    }

    context.read<SetProfileCubit>().setupProfile(
      ProfileRequestModel(
        headline: _headlineController.text.trim(),
        bio: _bioController.text.trim(),
        profileUrl: _avatarUrl,
        location: _locationController.text.trim(),
        gender: _selectedGender!,
        age: int.tryParse(_ageController.text.trim()) ?? 0,
        interests: selectedInterests,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<EditProfileCubit>()),
        BlocProvider(create: (_) => getIt<SetProfileCubit>()),
        BlocProvider(create: (_) => getIt<CreateFaceCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SetProfileCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Profile saved successfully',
                  );
                  context.replace(AppRoutes.faceVerificationSteps);
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

          BlocListener<EditProfileCubit, BaseApiState<String>>(
            listener: (context, state) {
              state.maybeWhen(
                success: (_) {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Profile saved successfully',
                  );
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
            return BlocBuilder<EditProfileCubit, BaseApiState<String>>(
              builder: (context, initialProfile) {
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
                          'Set up your profile',
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
                                      onTap: () {
                                        _pickAvatar(context);
                                      },
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
                                                        errorBuilder: (_, _, _) =>
                                                            _AvatarPlaceholder(
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
                                      'Please upload a clear photo of yourself where your face is clearly visible as this image will be used to verify your identity later .',
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
                                hint: 'Tell people about yourself',
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
                                controller: _ageController,
                                label: 'Age',
                                hint: 'e.g. 25',
                                icon: Icons.calendar_today_outlined,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your age';
                                  }
                                  final age = int.tryParse(value);
                                  if (age == null || age <= 0) {
                                    return 'Enter a valid age';
                                  }
                                  return null;
                                },
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
                              const SizedBox(height: 20),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedGender,

                                icon: const Icon(Icons.expand_more_rounded),

                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.softPrimary,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.wc_rounded,
                                    color: AppColors.primary,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                items: _genderOptions
                                    .map(
                                      (gender) => DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(
                                          gender,
                                          style: AppTextStyles.rubik.copyWith(
                                            fontSize: 14,
                                            color: AppColors.softPrimary,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) =>
                                    setState(() => _selectedGender = value),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Select your gender'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Interests',
                                style: AppTextStyles.rubik.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.softPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              MultiDropdown<String>(
                                items: _interestItems,
                                controller: _interestsController,
                                enabled: true,
                                searchEnabled: true,
                                chipDecoration: ChipDecoration(
                                  backgroundColor: AppColors.primary
                                      .withOpacity(0.1),
                                  wrap: true,
                                  runSpacing: 6,
                                  spacing: 6,
                                  labelStyle: AppTextStyles.rubik.copyWith(
                                    fontSize: 12.5,
                                    color: AppColors.softPrimary,
                                  ),
                                ),
                                fieldDecoration: FieldDecoration(
                                  hintText: 'Select your interests',
                                  hintStyle: AppTextStyles.rubik.copyWith(
                                    fontSize: 14,
                                    color: AppColors.softPrimary,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.interests_outlined,
                                    color: AppColors.primary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                dropdownDecoration: DropdownDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                validator: (items) =>
                                    items == null || items.isEmpty
                                    ? 'Select at least one interest'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: InputField(
                                      controller: _customInterestController,
                                      label: 'Add a custom interest',
                                      hint: 'e.g. Hiking',
                                      icon: Icons.add_circle_outline,
                                      onFieldSubmitted: (_) =>
                                          _addCustomInterest(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: IconButton(
                                      onPressed: _addCustomInterest,
                                      icon: const Icon(Icons.add_rounded),
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.white,
                                        shape: const CircleBorder(),
                                      ),
                                    ),
                                  ),
                                ],
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
