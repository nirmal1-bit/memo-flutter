import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/timeline/cubits/create_memories_cubit.dart';
import 'package:memo/features/timeline/cubits/get_memories_cubit.dart';
import 'package:memo/features/timeline/data/response/memory_response.dart';
import 'package:memo/features/timeline/presentation/widgets/bottom%20sheet/add_timeline_bottom_sheet.dart';
import 'package:memo/features/timeline/presentation/widgets/memory/timeline_add_memory_button.dart';
import 'package:memo/features/timeline/presentation/widgets/memory/timeline_memory_card.dart';
import 'package:memo/features/timeline/presentation/widgets/memory/timeline_memory_state_sliver.dart';
import 'package:memo/features/timeline/presentation/widgets/common/timeline_shared_widgets.dart';

class TimelineMemoriesTab extends StatefulWidget {
  const TimelineMemoriesTab({super.key, required this.connectionId});
  final int connectionId;

  @override
  State<TimelineMemoriesTab> createState() => _TimelineMemoriesTabState();
}

class _TimelineMemoriesTabState extends State<TimelineMemoriesTab> {
  String? _filter;

  static const _availableTypes = <String>[
    'personal',
    'work',
    'behavioral',
    'event',
    'reminder',
  ];

  Color _typeColor(String type) => switch (_normalizeType(type)) {
    'personal' => AppColors.accentRose,
    'work' => AppColors.primary,
    'behavioral' => AppColors.timelineMem,
    'event' => AppColors.secondary,
    'reminder' => const Color(0xFF7C4DFF),
    _ => AppColors.timelineMem,
  };

  Color _typeBg(String type) => switch (_normalizeType(type)) {
    'personal' => const Color(0xFFFBEAF0),
    'work' => AppColors.brandBackground,
    'behavioral' => AppColors.chipOrangeBg,
    'event' => AppColors.chipPurpleBg,
    'reminder' => const Color(0xFFF1EBFF),
    _ => AppColors.brandBackground,
  };

  String _typeLabel(String type) => switch (_normalizeType(type)) {
    'personal' => 'Personal',
    'work' => 'Work',
    'behavioral' => 'Behavioral',
    'event' => 'Event',
    'reminder' => 'Reminder',
    _ => type,
  };

  IconData _typeIcon(String type) => switch (_normalizeType(type)) {
    'personal' => Icons.favorite_border_rounded,
    'work' => Icons.work_outline_rounded,
    'behavioral' => Icons.psychology_outlined,
    'event' => Icons.event_rounded,
    'reminder' => Icons.notifications_none_rounded,
    _ => Icons.label_outline_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<CreateMemoriesCubit>())],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreateMemoriesCubit, BaseApiState<MemoryResponse>>(
            listener: (context, state) async {
              state.maybeWhen(
                success: (data) async {
                  AppUtils.showSuccessSnackbar(
                    context: context,
                    message: 'Memory Added successfully',
                  );
                  context.read<GetMemoriesCubit>().updateMemory(data);
                  if (!context.mounted) {
                    return;
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
        child:
            BlocBuilder<GetMemoriesCubit, BaseApiState<List<MemoryResponse>>>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                        child: SizedBox(
                          height: 36,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _availableTypes.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return TimelineFilterChip(
                                  label: 'All',
                                  selected: _filter == null,
                                  onTap: () => setState(() => _filter = null),
                                );
                              }

                              final type = _availableTypes[index - 1];
                              return TimelineFilterChip(
                                label: _typeLabel(type),
                                selected: _filter == type,
                                onTap: () => setState(
                                  () => _filter = _filter == type ? null : type,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                        child: TimelineAddMemoryButton(
                          onTap: () =>
                              showAddMemorySheet(context, widget.connectionId),
                        ),
                      ),
                    ),
                    _buildStateSliver(state),
                  ],
                );
              },
            ),
      ),
    );
  }

  Widget _buildStateSliver(BaseApiState<List<MemoryResponse>> state) {
    return state.when(
      initial: () => const TimelineMemoryLoadingSliver(),
      loading: () => const TimelineMemoryLoadingSliver(),
      error: (message) => TimelineMemoryStatusSliver(
        icon: Icons.error_outline_rounded,
        title: 'Unable to load memories',
        message: message,
      ),
      noInternet: () => const TimelineMemoryStatusSliver(
        icon: Icons.wifi_off_rounded,
        title: 'No internet connection',
        message: 'Check your connection and try again.',
      ),
      validationError: (validationError) => TimelineMemoryStatusSliver(
        icon: Icons.warning_amber_rounded,
        title: validationError.message,
        message: validationError.errors.isNotEmpty
            ? validationError.errors.values.first.toString()
            : 'Please review the request and try again.',
      ),
      success: (memories) {
        final filtered = _filter == null
            ? memories
            : context.read<GetMemoriesCubit>().memoriesByType(_filter!);

        if (memories.isEmpty) {
          return const TimelineMemoryStatusSliver(
            icon: Icons.bookmark_border_rounded,
            title: 'No memories yet',
            message: 'Memories for this connection will appear here.',
          );
        }

        if (filtered.isEmpty) {
          return const TimelineMemoryStatusSliver(
            icon: Icons.filter_alt_off_rounded,
            title: 'No memories in this category',
            message: 'Try a different filter to view more entries.',
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final memory = filtered[index];
              final typeLabel = _typeLabel(memory.type);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TimelineMemoryCard(
                  title: _memoryTitle(memory.content),
                  body: memory.content,
                  date: memory.createdAt,
                  typeColor: _typeColor(memory.type),
                  typeBg: _typeBg(memory.type),
                  typeLabel: typeLabel,
                  typeIcon: _typeIcon(memory.type),
                  tags: [typeLabel],
                ),
              );
            }, childCount: filtered.length),
          ),
        );
      },
    );
  }

  String _memoryTitle(String content) {
    final cleaned = content.trim().replaceAll('\n', ' ');
    if (cleaned.isEmpty) {
      return 'Memory';
    }

    final sentence = cleaned.split(RegExp(r'[.!?]')).first.trim();
    final title = sentence.isEmpty ? cleaned : sentence;
    if (title.length <= 52) {
      return title;
    }

    return '${title.substring(0, 52).trimRight()}...';
  }

  String _normalizeType(String type) {
    final normalized = type.trim().toLowerCase();
    if (normalized == 'behaviour') {
      return 'behavioral';
    }

    return normalized;
  }
}
