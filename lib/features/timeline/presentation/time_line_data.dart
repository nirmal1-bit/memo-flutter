enum MemoryType { personal, work, event, behaviour }

class MemoryEntry {
  const MemoryEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.type,
    this.tags = const [],
  });

  final String id;
  final String title;
  final String body;
  final DateTime date;
  final MemoryType type;
  final List<String> tags;
}

enum TimelineEventType { call, message, meeting, video, memory }

class TimelineEntry {
  const TimelineEntry({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.type,
    this.extra,
  });

  final String title;
  final String subtitle;
  final DateTime date;
  final TimelineEventType type;
  final String? extra;
}

class AiMessage {
  const AiMessage({required this.isAi, required this.text});

  final bool isAi;
  final String text;
}

final List<MemoryEntry> dummyMemories = [
  MemoryEntry(
    id: '1',
    title: 'Prefers async voice notes',
    body:
        'Always replies to voice messages faster than text. Mentioned she finds long texts overwhelming during busy sprints.',
    date: DateTime(2026, 4, 3),
    type: MemoryType.behaviour,
    tags: ['Behaviour', 'Communication'],
  ),
  MemoryEntry(
    id: '2',
    title: 'Birthday · March 14',
    body:
        'Loves dark chocolate (70% cacao). Sent a gift box last year — she replied with a voice note saying it made her day.',
    date: DateTime(2026, 3, 14),
    type: MemoryType.personal,
    tags: ['Personal', 'Annual'],
  ),
  MemoryEntry(
    id: '3',
    title: 'PLG transition — Q3 target',
    body:
        'Moving from B2B sales-led to product-led growth. Engineering bandwidth is the main constraint. Three open backend roles as of April 2026.',
    date: DateTime(2026, 4, 14),
    type: MemoryType.work,
    tags: ['Work', 'Strategy', 'PLG'],
  ),
  MemoryEntry(
    id: '4',
    title: 'Met at ProductConf Bangalore',
    body:
        'She was speaking on retention loops. Exchanged numbers after her talk. Said she was open to advisory conversations.',
    date: DateTime(2026, 2, 2),
    type: MemoryType.event,
    tags: ['Event', 'First meet'],
  ),
  MemoryEntry(
    id: '5',
    title: 'Favourite coffee: oat flat white',
    body:
        'Mentioned it twice during calls. Could be a good detail for an in-person meeting.',
    date: DateTime(2026, 1, 20),
    type: MemoryType.personal,
    tags: ['Personal', 'IRL'],
  ),
];

final List<TimelineEntry> dummyTimeline = [
  TimelineEntry(
    title: 'Roadmap pivot discussion',
    subtitle: '38 min · Transcript saved',
    date: DateTime(2026, 4, 14),
    type: TimelineEventType.video,
    extra: 'PLG, eng bandwidth, Q3 plan',
  ),
  TimelineEntry(
    title: 'Quick check-in',
    subtitle: 'Followed up on hiring timelines',
    date: DateTime(2026, 4, 9),
    type: TimelineEventType.message,
  ),
  TimelineEntry(
    title: 'Memory added',
    subtitle: 'Prefers async voice notes',
    date: DateTime(2026, 4, 3),
    type: TimelineEventType.memory,
  ),
  TimelineEntry(
    title: 'Birthday · gift sent',
    subtitle: 'Dark chocolate gift box',
    date: DateTime(2026, 3, 14),
    type: TimelineEventType.memory,
    extra: 'She replied with a voice note',
  ),
  TimelineEntry(
    title: 'Catch-up call · 22 min',
    subtitle: 'Series B close, team expansion',
    date: DateTime(2026, 3, 4),
    type: TimelineEventType.call,
  ),
  TimelineEntry(
    title: 'ProductConf Bangalore',
    subtitle: 'First in-person meeting',
    date: DateTime(2026, 2, 2),
    type: TimelineEventType.meeting,
    extra: 'Exchanged numbers after her talk',
  ),
];
