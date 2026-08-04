class ChatHistoryResponse {
  const ChatHistoryResponse({
    required this.id,
    required this.connectionId,
    required this.senderId,
    required this.type,
    required this.message,
    required this.createdAt,
  });

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ChatHistoryResponse(
      id: (json['id'] as num).toInt(),
      connectionId: (json['connection_id'] as num).toInt(),
      senderId: (json['sender_id'] as num).toInt(),
      type: (json['type'] ?? 'message').toString(),
      message: (json['message'] ?? '').toString(),
      createdAt: DateTime.parse(json['created_at'].toString()),
    );
  }

  final int id;
  final int connectionId;
  final int senderId;
  final String type;
  final String message;
  final DateTime createdAt;
}

class ChatHistoryPagination {
  const ChatHistoryPagination({
    required this.currentPage,
    required this.pageSize,
    required this.firstPage,
    required this.lastPage,
    required this.totalRecords,
  });

  factory ChatHistoryPagination.fromJson(Map<String, dynamic> json) {
    return ChatHistoryPagination(
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      pageSize: (json['page_size'] as num?)?.toInt() ?? 10,
      firstPage: (json['first_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      totalRecords: (json['total_records'] as num?)?.toInt() ?? 0,
    );
  }

  final int currentPage;
  final int pageSize;
  final int firstPage;
  final int lastPage;
  final int totalRecords;
}

class ChatHistoryPage {
  const ChatHistoryPage({required this.items, required this.pagination});

  final List<ChatHistoryResponse> items;
  final ChatHistoryPagination pagination;
}
