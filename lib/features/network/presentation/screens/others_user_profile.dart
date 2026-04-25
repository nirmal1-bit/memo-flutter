import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';

enum _OtherUserTab { chat, profile }

class OthersUserProfileScreen extends StatefulWidget {
  const OthersUserProfileScreen({super.key, required this.details});

  final OtherUserDetails? details;

  @override
  State<OthersUserProfileScreen> createState() =>
      _OthersUserProfileScreenState();
}

class _OthersUserProfileScreenState extends State<OthersUserProfileScreen> {
  _OtherUserTab _selectedTab = _OtherUserTab.profile;

  @override
  Widget build(BuildContext context) {
    final user = widget.details;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        foregroundColor: AppColors.softPrimary,
        actions: user != null && _selectedTab == _OtherUserTab.chat
            ? [
                IconButton(
                  tooltip: 'Start video call',
                  onPressed: () => _startVideoCall(context, user),
                  icon: const Icon(Icons.videocam_rounded),
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: user == null
            ? _MissingUserState(onBack: () => Navigator.of(context).pop())
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderCard(user: user),
                    const SizedBox(height: 18),
                    _TabStrip(
                      selectedTab: _selectedTab,
                      onChanged: (tab) {
                        setState(() {
                          _selectedTab = tab;
                        });
                      },
                    ),
                    const SizedBox(height: 18),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: _selectedTab == _OtherUserTab.profile
                          ? _ProfileTab(
                              key: const ValueKey('profile-tab'),
                              user: user,
                            )
                          : _ChatTab(
                              key: const ValueKey('chat-tab'),
                              user: user,
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _startVideoCall(BuildContext context, OtherUserDetails user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting video call with ${user.name}...')),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.user});

  final OtherUserDetails user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;
    final initials = _buildInitials(user.name);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 72,
              height: 72,
              color: AppColors.brandBackground,
              child: profile?.avatarUrl.isNotEmpty ?? false
                  ? Image.network(
                      profile!.avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _AvatarFallback(initials: initials),
                    )
                  : _AvatarFallback(initials: initials),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: AppTextStyles.libre.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.softPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.role,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.softTextGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(text: user.activated ? 'Active' : 'Pending'),
                    _InfoChip(text: user.isPremium ? 'Premium' : 'Standard'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return 'U';
    }

    final first = parts.first[0];
    final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({super.key, required this.user});

  final OtherUserDetails user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailCard(
          title: 'About',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailRow(label: 'Email', value: user.email),
              _DetailRow(
                label: 'Activated',
                value: user.activated ? 'Yes' : 'No',
              ),
              _DetailRow(label: 'Joined', value: _formatDate(user.createdAt)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _DetailCard(
          title: 'Profile',
          child: user.profile == null
              ? Text(
                  'No profile details available yet.',
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13.5,
                    color: AppColors.softTextGrey,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(
                      label: 'Headline',
                      value: user.profile!.headline,
                    ),
                    _DetailRow(label: 'Bio', value: user.profile!.bio),
                    _DetailRow(
                      label: 'Company',
                      value: user.profile!.companyName,
                    ),
                    _DetailRow(
                      label: 'Location',
                      value: user.profile!.location,
                    ),
                    _DetailRow(label: 'Website', value: user.profile!.website),
                    _DetailRow(
                      label: 'Profile Link',
                      value: user.profile!.profileUrl,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _ChatTab extends StatefulWidget {
  const _ChatTab({super.key, required this.user});

  final OtherUserDetails user;

  @override
  State<_ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<_ChatTab> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messagesController = ScrollController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text: 'Hey, good to connect here.',
      isMe: false,
      timeLabel: '9:20',
    ),
    const _ChatMessage(
      text: 'Likewise. This chat view is ready for real messages.',
      isMe: true,
      timeLabel: '9:21',
    ),
    const _ChatMessage(
      text: 'Use the composer below to send another message.',
      isMe: false,
      timeLabel: '9:22',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _messagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.user.profile;
    final firstName = _firstName(widget.user.name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailCard(
          title: 'Chat',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.statusGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.name,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.softBlack,
                          ),
                        ),
                        Text(
                          profile?.headline ?? 'Available for chat',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 11.5,
                            color: AppColors.softTextGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Start video call',
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Starting video call with ${widget.user.name}...',
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.videocam_rounded),
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 320,
                child: ListView.separated(
                  controller: _messagesController,
                  itemCount: _messages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _ChatBubble(
                      alignEnd: message.isMe,
                      text: message.text,
                      timeLabel: message.timeLabel,
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              _ChatComposer(
                controller: _messageController,
                onSend: _sendMessage,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(
        _ChatMessage(text: text, isMe: true, timeLabel: _currentTimeLabel()),
      );
    });

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_messagesController.hasClients) {
        return;
      }

      _messagesController.animateTo(
        _messagesController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  String _currentTimeLabel() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final suffix = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $suffix';
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            minLines: 1,
            maxLines: 4,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => onSend(),
            decoration: InputDecoration(
              hintText: 'Write a message...',
              filled: true,
              fillColor: AppColors.brandBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onSend,
            borderRadius: BorderRadius.circular(16),
            child: const SizedBox(
              width: 52,
              height: 52,
              child: Icon(Icons.send_rounded, color: AppColors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class _TabStrip extends StatelessWidget {
  const _TabStrip({required this.selectedTab, required this.onChanged});

  final _OtherUserTab selectedTab;
  final ValueChanged<_OtherUserTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'Chat',
              active: selectedTab == _OtherUserTab.chat,
              onTap: () => onChanged(_OtherUserTab.chat),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _TabButton(
              label: 'Profile',
              active: selectedTab == _OtherUserTab.profile,
              onTap: () => onChanged(_OtherUserTab.profile),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            label,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: active ? AppColors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.brandBackground,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.libre.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.softPrimary,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 12,
              color: AppColors.softTextGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13.5,
              height: 1.45,
              color: AppColors.softBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.alignEnd,
    required this.text,
    required this.timeLabel,
  });

  final bool alignEnd;
  final String text;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: alignEnd
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: alignEnd ? AppColors.primary : AppColors.brandBackground,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(alignEnd ? 18 : 6),
                bottomRight: Radius.circular(alignEnd ? 6 : 18),
              ),
            ),
            child: Text(
              text,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13.5,
                height: 1.4,
                color: alignEnd ? AppColors.white : AppColors.softBlack,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            timeLabel,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 10.5,
              color: AppColors.softTextGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.isMe,
    required this.timeLabel,
  });

  final String text;
  final bool isMe;
  final String timeLabel;
}

class _MissingUserState extends StatelessWidget {
  const _MissingUserState({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.dividerColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person_off_rounded,
                color: AppColors.primary,
                size: 42,
              ),
              const SizedBox(height: 12),
              Text(
                'No user details were passed from the network card.',
                textAlign: TextAlign.center,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13.5,
                  color: AppColors.softTextGrey,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: onBack, child: const Text('Go Back')),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime value) {
  final local = value.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  return '${local.year}-$month-$day';
}

String _firstName(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  return parts.isNotEmpty && parts.first.isNotEmpty ? parts.first : name;
}
