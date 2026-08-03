import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/home/data/models/response/connection_response.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';
import 'package:memo/features/home/presentation/cubits/connections_cubit.dart';
import 'package:memo/features/home/presentation/cubits/connection_action_cubit.dart';
import 'package:memo/features/home/presentation/cubits/get_user_profile_cubit.dart';
import 'package:memo/features/home/presentation/cubits/received_connections_cubit.dart';
import 'package:memo/features/home/presentation/cubits/sent_connections_cubit.dart';
import 'package:memo/features/home/presentation/cubits/send_location_cubit.dart';
import 'package:memo/features/home/presentation/widgets/connections/connections_app_bar.dart';
import 'package:memo/features/home/presentation/widgets/connections/connections_widgets.dart';
import 'package:memo/features/quest/presentation/quest_screen.dart';
import 'package:memo/features/timeline/presentation/time_line_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ConnectionsCubit _connectionsCubit;
  late final SentConnectionsCubit _sentConnectionsCubit;
  late final ReceivedConnectionsCubit _receivedConnectionsCubit;
  late final GetUserProfileCubit _userProfileCubit;
  late final ConnectionActionCubit _connectionActionCubit;
  late final SendLocationCubit _sendLocationCubit;

  ConnectionTab _selectedTab = ConnectionTab.connections;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectionsCubit = getIt<ConnectionsCubit>()..listConnections();
    _sentConnectionsCubit = getIt<SentConnectionsCubit>()
      ..listSentConnections();
    _receivedConnectionsCubit = getIt<ReceivedConnectionsCubit>()
      ..listReceivedConnections();
    _userProfileCubit = getIt<GetUserProfileCubit>()..getUserProfile();
    _connectionActionCubit = getIt<ConnectionActionCubit>();
    _sendLocationCubit = getIt<SendLocationCubit>()..sendLocation();
  }

  @override
  void dispose() {
    _connectionsCubit.close();
    _sentConnectionsCubit.close();
    _receivedConnectionsCubit.close();
    _userProfileCubit.close();
    _connectionActionCubit.close();
    _sendLocationCubit.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _connectionsCubit),
        BlocProvider.value(value: _sentConnectionsCubit),
        BlocProvider.value(value: _receivedConnectionsCubit),
        BlocProvider.value(value: _userProfileCubit),
        BlocProvider.value(value: _connectionActionCubit),
        BlocProvider.value(value: _sendLocationCubit),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<
                GetUserProfileCubit,
                BaseApiState<UserProfileResponse>
              >(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (data) {
                      if (data.profile == null) {
                        context.replace(AppRoutes.setProfile);
                      }
                    },
                    error: (message) {},
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
              BlocListener<ConnectionActionCubit, BaseApiState<String>>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (message) {
                      AppUtils.showSuccessSnackbar(
                        context: context,
                        message: message,
                      );
                      context.read<ConnectionsCubit>().listConnections();
                      context
                          .read<SentConnectionsCubit>()
                          .listSentConnections();
                      context
                          .read<ReceivedConnectionsCubit>()
                          .listReceivedConnections();
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
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: 0,
                backgroundColor: AppColors.scaffoldBackground,
              ),
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<ConnectionsCubit>().listConnections();
                      context
                          .read<SentConnectionsCubit>()
                          .listSentConnections();
                      context
                          .read<ReceivedConnectionsCubit>()
                          .listReceivedConnections();
                      context.read<GetUserProfileCubit>().getUserProfile();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          BlocBuilder<
                            GetUserProfileCubit,
                            BaseApiState<UserProfileResponse>
                          >(
                            builder: (context, state) {
                              return state.when(
                                initial: () => const SizedBox.shrink(),
                                loading: () => ProductBannerShimmer(),
                                success: (user) => ConnectionsAppBar(
                                  user: user,
                                  controller: _searchController,
                                  onSearchPressed: () =>
                                      _receivedConnectionsCubit
                                          .filterReceivedConnectionsByName(
                                            _searchController.text,
                                          ),
                                  onTap: () =>
                                      context.push(AppRoutes.userProfile),
                                  onActionTap: () =>
                                      context.push(AppRoutes.addConnection),
                                ),
                                error: (_) => const SizedBox.shrink(),
                                noInternet: () => const SizedBox.shrink(),
                                validationError: (_) => const SizedBox.shrink(),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          ConnectionTabStrip(
                            selected: _selectedTab,
                            onChanged: (tab) =>
                                setState(() => _selectedTab = tab),
                          ),
                          const SizedBox(height: 30),
                          _buildTabContent(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    switch (_selectedTab) {
      case ConnectionTab.connections:
        return BlocBuilder<
          ConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) => ConnectionsStateView(
            state: state,
            emptyMessage: 'No connections yet.\nStart building your network.',
            onConnectionTap: (connection) => context.push(
              AppRoutes.timeLine,
              extra: TimeLineScreenParams(
                profile: connection.userProfile,
                connectionId: connection.id,
              ),
            ),
            onQuestTap: (connection) {
              final user = context.read<GetUserProfileCubit>().state.maybeWhen(
                success: (user) => user.profile,
                orElse: () => null,
              );

              context.push(
                AppRoutes.quest,
                extra: QuestScreenParams(
                  connectionId: connection.id,
                  user:
                      user ??
                      Profile(
                        id: 0,
                        userId: 0,
                        headline: "",
                        bio: "",
                        profileUrl: ":",
                        location: "",
                        age: 0,
                        gender: "",
                        interests: [],
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                  person: connection.userProfile,
                ),
              );
            },
            onChatTap: (connection) =>
                context.push(AppRoutes.chat, extra: connection),
            onDeleteTap: (connection) => AppUtils.confirmationDialog(
              context: context,
              title: 'Delete connection?',
              message:
                  'This will permanently delete the connection, memories, timeline, and shared album. Do you want to continue?',
              onConfirm: () => context
                  .read<ConnectionActionCubit>()
                  .deleteConnection(connection.id),
            ),
          ),
        );
      case ConnectionTab.sent:
        return BlocBuilder<
          SentConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) => ConnectionsStateView(
            state: state,
            emptyMessage: 'No sent requests yet.',
            cardStyle: ConnectionCardStyle.sent,
            onSentTap: (connection) => context.push(
              AppRoutes.otherUserProfile,
              extra: Profile(
                id: connection.userProfile.id,
                userId: connection.userProfile.userId,
                headline: connection.userProfile.headline,
                bio: connection.userProfile.bio,
                profileUrl: connection.userProfile.profileUrl,
                location: connection.userProfile.location,
                age: connection.userProfile.age,
                gender: connection.userProfile.gender,
                interests: connection.userProfile.interests,
                createdAt: connection.userProfile.createdAt,
                updatedAt: connection.userProfile.updatedAt,
              ),
            ),
            onCancelTap: (connection) => context
                .read<ConnectionActionCubit>()
                .cancelConnectionRequest(connection.id),
          ),
        );
      case ConnectionTab.received:
        return BlocBuilder<
          ReceivedConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) => ConnectionsStateView(
            state: state,
            emptyMessage: 'No received requests yet.',
            cardStyle: ConnectionCardStyle.received,
            onReceivedTap: (connection) => context.push(
              AppRoutes.otherUserProfile,
              extra: Profile(
                id: connection.userProfile.id,
                userId: connection.userProfile.userId,
                headline: connection.userProfile.headline,
                bio: connection.userProfile.bio,
                profileUrl: connection.userProfile.profileUrl,
                location: connection.userProfile.location,
                age: connection.userProfile.age,
                gender: connection.userProfile.gender,
                interests: connection.userProfile.interests,
                createdAt: connection.userProfile.createdAt,
                updatedAt: connection.userProfile.updatedAt,
              ),
            ),
            onAcceptTap: (connection) {
              context.read<ConnectionActionCubit>().acceptConnectionRequest(
                connection.id,
              );
            },

            // here we are defning a signature for the onAcceptTap the caller of
            // this function will pass a connection object
            //and we will use the connection id to call the
            //acceptConnectionRequest method of the ConnectionActionCubit.
            onRejectTap: (connection) => context
                .read<ConnectionActionCubit>()
                .rejectConnectionRequest(connection.id),
          ),
        );
    }
  }
}
