import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/cubits/connections_cubit.dart';
import 'package:memo/features/network/presentation/cubits/received_connections_cubit.dart';
import 'package:memo/features/network/presentation/cubits/sent_connections_cubit.dart';
import 'package:memo/features/network/presentation/widgets/add_button.dart';
import 'package:memo/features/network/presentation/widgets/network_state_view.dart';
import 'package:memo/features/network/presentation/widgets/search_field.dart';
import 'package:memo/features/network/presentation/widgets/tab_strip.dart';
import 'package:memo/features/network/presentation/widgets/top_header.dart';

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

  NetworkTab _selectedTab = NetworkTab.connections;

  @override
  void initState() {
    super.initState();
    _connectionsCubit = getIt<ConnectionsCubit>()..listConnections();
    _sentConnectionsCubit = getIt<SentConnectionsCubit>()
      ..listSentConnections();
    _receivedConnectionsCubit = getIt<ReceivedConnectionsCubit>()
      ..listReceivedConnections();
  }

  @override
  void dispose() {
    _connectionsCubit.close();
    _sentConnectionsCubit.close();
    _receivedConnectionsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _connectionsCubit),
        BlocProvider.value(value: _sentConnectionsCubit),
        BlocProvider.value(value: _receivedConnectionsCubit),
      ],
      child: Container(
        color: AppColors.scaffoldBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: widget.controller,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: SearchField(hintText: 'Search network or content'),
                    ),
                    const SizedBox(width: 12),
                    AddButton(onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 18),
                TabStrip(
                  selectedTab: _selectedTab,
                  onChanged: (tab) {
                    setState(() {
                      _selectedTab = tab;
                    });
                  },
                ),
                const SizedBox(height: 24),
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
          builder: (context, state) {
            return NetworkStateView(
              state: state,
              emptyMessage: 'You do not have any connections yet.',
            );
          },
        );
      case NetworkTab.sent:
        return BlocBuilder<
          SentConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) {
            return NetworkStateView(
              state: state,
              emptyMessage: 'No sent requests yet.',
            );
          },
        );
      case NetworkTab.received:
        return BlocBuilder<
          ReceivedConnectionsCubit,
          BaseApiState<List<ConnectionResponse>>
        >(
          builder: (context, state) {
            return NetworkStateView(
              state: state,
              emptyMessage: 'No received requests yet.',
            );
          },
        );
    }
  }
}
