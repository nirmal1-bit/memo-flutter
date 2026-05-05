class MemoryRequest {
  MemoryRequest({
    required this.connectionId,
    required this.content,
    required this.type,
  });

  final int connectionId;
  final String content;
  final String type;

  Map<String, dynamic> toJson() => {
    'connection_id': connectionId,
    'content': content,
    'type': type,
  };
}
