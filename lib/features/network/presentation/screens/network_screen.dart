import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/cubits/connections_cubit.dart';
import 'package:memo/features/network/presentation/cubits/connection_action_cubit.dart';
import 'package:memo/features/network/presentation/cubits/get_user_profile_cubit.dart';
import 'package:memo/features/network/presentation/cubits/received_connections_cubit.dart';
import 'package:memo/features/network/presentation/cubits/sent_connections_cubit.dart';
import 'package:memo/features/network/presentation/screens/other_user_profile.dart';
import 'package:memo/features/network/presentation/widgets/app_bar.dart';
import 'package:memo/features/network/presentation/widgets/network_screen_widgets.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  late final ConnectionsCubit _connectionsCubit;
  late final SentConnectionsCubit _sentConnectionsCubit;
  late final ReceivedConnectionsCubit _receivedConnectionsCubit;
  late final GetUserProfileCubit _userProfileCubit;
  late final ConnectionActionCubit _connectionActionCubit;

  NetworkTab _selectedTab = NetworkTab.connections;
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
  }

  @override
  void dispose() {
    _connectionsCubit.close();
    _sentConnectionsCubit.close();
    _receivedConnectionsCubit.close();
    _userProfileCubit.close();
    _connectionActionCubit.close();
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
                        context.push(AppRoutes.setProfile);
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
                                success: (user) => NetworkAppBar(
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
                          NetworkTabStrip(
                            selected: _selectedTab,
                            onChanged: (tab) =>
                                setState(() => _selectedTab = tab),
                          ),
                          const SizedBox(height: 30),
                          _buildTabContent(),
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

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case NetworkTab.connections:
        return BlocBuilder<
          ConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) => NetworkStateView(
            state: state,
            emptyMessage: 'No connections yet.\nStart building your network.',
            onConnectionTap: (connection) => context.push(
              AppRoutes.timeLine,
              extra: OtherUserProfileArguments(
                details: connection.otherUserDetails,
                connectionId: connection.id,
              ),
            ),
            onChatTap: (connection) =>
                context.push(AppRoutes.chat, extra: connection),
            onCallTap: (connection) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Starting a video call with ${connection.otherUserDetails.name}...',
                ),
              ),
            ),
          ),
        );
      case NetworkTab.sent:
        return BlocBuilder<
          SentConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) => NetworkStateView(
            state: state,
            emptyMessage: 'No sent requests yet.',
            cardStyle: NetworkCardStyle.sent,
            onSentTap: (connection) => context.push(
              AppRoutes.otherUserProfile,
              extra: OtherUserProfileArguments(
                details: connection.otherUserDetails,
                isFromSent: true,
              ),
            ),
            onCancelTap: (connection) => context
                .read<ConnectionActionCubit>()
                .cancelConnectionRequest(connection.id),
          ),
        );
      case NetworkTab.received:
        return BlocBuilder<
          ReceivedConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) => NetworkStateView(
            state: state,
            emptyMessage: 'No received requests yet.',
            cardStyle: NetworkCardStyle.received,
            onReceivedTap: (connection) => context.push(
              AppRoutes.otherUserProfile,
              extra: OtherUserProfileArguments(
                details: connection.otherUserDetails,
                isFromReceived: true,
              ),
            ),
            onAcceptTap: (connection) => context
                .read<ConnectionActionCubit>()
                .acceptConnectionRequest(connection.id),
            onRejectTap: (connection) => context
                .read<ConnectionActionCubit>()
                .rejectConnectionRequest(connection.id),
          ),
        );
    }
  }
}
