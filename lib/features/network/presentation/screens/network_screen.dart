import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/cubits/connections_cubit.dart';
import 'package:memo/features/network/presentation/cubits/get_user_profile_cubit.dart';
import 'package:memo/features/network/presentation/cubits/received_connections_cubit.dart';
import 'package:memo/features/network/presentation/cubits/sent_connections_cubit.dart';
import 'package:memo/features/network/presentation/widgets/app_bar.dart';
import 'package:memo/features/network/presentation/widgets/network_screen_widgets.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key, required this.controller});

  final ScrollController controller;

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  late final ConnectionsCubit _connectionsCubit;
  late final SentConnectionsCubit _sentConnectionsCubit;
  late final ReceivedConnectionsCubit _receivedConnectionsCubit;
  late final GetUserProfileCubit _userProfileCubit;

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
  }

  @override
  void dispose() {
    _connectionsCubit.close();
    _sentConnectionsCubit.close();
    _receivedConnectionsCubit.close();
    _userProfileCubit.close();
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
      ],
      child: Container(
        color: AppColors.scaffoldBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: widget.controller,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<
                  GetUserProfileCubit,
                  BaseApiState<UserProfileResponse>
                >(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const SizedBox.shrink(),
                      success: (user) => NetworkAppBar(
                        user: user,
                        onTap: () => context.push(AppRoutes.userProfile),
                      ),
                      error: (_) => const SizedBox.shrink(),
                      noInternet: () => const SizedBox.shrink(),
                      validationError: (_) => const SizedBox.shrink(),
                    );
                  },
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: NetworkSearchBar(controller: _searchController),
                    ),
                    const SizedBox(width: 10),
                    NetworkAddButton(onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 14),
                NetworkTabStrip(
                  selected: _selectedTab,
                  onChanged: (tab) => setState(() => _selectedTab = tab),
                ),
                const SizedBox(height: 16),
                _buildTabContent(),
              ],
            ),
          ),
        ),
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
              AppRoutes.otherUserProfile,
              extra: connection.otherUserDetails,
            ),
            onChatTap: (connection) => context.push(
              AppRoutes.otherUserProfile,
              extra: connection.otherUserDetails,
            ),
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
          ),
        );
    }
  }
}
