import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/presentation/widgets/add_button.dart';
import 'package:memo/features/network/presentation/widgets/pending_request_card.dart';
import 'package:memo/features/network/presentation/widgets/search_field.dart';
import 'package:memo/features/network/presentation/widgets/tab_strip.dart';
import 'package:memo/features/network/presentation/widgets/top_header.dart';
import 'package:memo/features/network/presentation/widgets/trusted_member_card.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key, required this.controller});

  final ScrollController controller;
  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  NetworkTab _selectedTab = NetworkTab.connections;

  static const List<_PendingRequestData> _pendingRequests = [
    _PendingRequestData(
      name: 'Dr. Julian Vance',
      role: 'Neuro-linguistics Expert',
      avatarSeed: 'JV',
    ),
    _PendingRequestData(
      name: 'Elena Rossi',
      role: 'Product Strategy',
      avatarSeed: 'ER',
    ),
    _PendingRequestData(
      name: 'Noah Patel',
      role: 'Design Systems Lead',
      avatarSeed: 'NP',
    ),
  ];

  static const List<_NetworkMemberData> _trustedMembers = [
    _NetworkMemberData(
      name: 'Marcus Thorne',
      role: 'Lead Systems Architect',
      avatarSeed: 'MT',
      metaLabel: 'Shared 12 memories',
    ),
    _NetworkMemberData(
      name: 'Sarah Jenkins',
      role: 'AI Research Lead',
      avatarSeed: 'SJ',
      metaLabel: 'Shared 4 projects',
    ),
    _NetworkMemberData(
      name: 'Priya Desai',
      role: 'Knowledge Curator',
      avatarSeed: 'PD',
      metaLabel: 'Shared 8 notes',
    ),

    _NetworkMemberData(
      name: 'Marcus Thorne',
      role: 'Lead Systems Architect',
      avatarSeed: 'MT',
      metaLabel: 'Shared 12 memories',
    ),
    _NetworkMemberData(
      name: 'Sarah Jenkins',
      role: 'AI Research Lead',
      avatarSeed: 'SJ',
      metaLabel: 'Shared 4 projects',
    ),
    _NetworkMemberData(
      name: 'Priya Desai',
      role: 'Knowledge Curator',
      avatarSeed: 'PD',
      metaLabel: 'Shared 8 notes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackground,
      child: SafeArea(
        child: SingleChildScrollView(
          controller: widget.controller,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopHeader(
                title: 'Network',
                subtitle:
                    'Manage your trusted circle and collaboration requests.',
              ),
              const SizedBox(height: 20),
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
                requestCount: _pendingRequests.length,
                onChanged: (tab) {
                  setState(() {
                    _selectedTab = tab;
                  });
                },
              ),
              const SizedBox(height: 24),
              if (_selectedTab == NetworkTab.requests) ...[
                Text(
                  'Pending Requests',
                  style: AppTextStyles.libre.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.softPrimary,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 12),
                ..._pendingRequests.map(
                  (request) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: PendingRequestCard(
                      name: request.name,
                      role: request.role,
                      avatarSeed: request.avatarSeed,
                    ),
                  ),
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trusted Network',
                      style: AppTextStyles.libre.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.softPrimary,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      'View all',
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._trustedMembers.map(
                  (member) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TrustedMemberCard(
                      name: member.name,
                      role: member.role,
                      avatarSeed: member.avatarSeed,
                      metaLabel: member.metaLabel,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PendingRequestData {
  const _PendingRequestData({
    required this.name,
    required this.role,
    required this.avatarSeed,
  });

  final String name;
  final String role;
  final String avatarSeed;
}

class _NetworkMemberData {
  const _NetworkMemberData({
    required this.name,
    required this.role,
    required this.avatarSeed,
    required this.metaLabel,
  });

  final String name;
  final String role;
  final String avatarSeed;
  final String metaLabel;
}
