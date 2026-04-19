class MessageModel {
  final String oid;
  final String senderOid;
  final String senderName;
  final String senderRoleRaw;
  final String receiverOid;
  final String receiverName;
  final String receiverRoleRaw;
  final String content;
  final DateTime? sentAt;
  final String name;
  final String role; // e.g. "(Parent)" or "(Student)"
  final String preview;
  final String time;
  final int unreadCount;
  final bool isOnline;

  const MessageModel({
    this.oid = '',
    this.senderOid = '',
    this.senderName = '',
    this.senderRoleRaw = '',
    this.receiverOid = '',
    this.receiverName = '',
    this.receiverRoleRaw = '',
    this.content = '',
    this.sentAt,
    required this.name,
    required this.role,
    required this.preview,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  MessageModel copyWith({
    String? oid,
    String? senderOid,
    String? senderName,
    String? senderRoleRaw,
    String? receiverOid,
    String? receiverName,
    String? receiverRoleRaw,
    String? content,
    DateTime? sentAt,
    String? name,
    String? role,
    String? preview,
    String? time,
    int? unreadCount,
    bool? isOnline,
  }) {
    return MessageModel(
      oid: oid ?? this.oid,
      senderOid: senderOid ?? this.senderOid,
      senderName: senderName ?? this.senderName,
      senderRoleRaw: senderRoleRaw ?? this.senderRoleRaw,
      receiverOid: receiverOid ?? this.receiverOid,
      receiverName: receiverName ?? this.receiverName,
      receiverRoleRaw: receiverRoleRaw ?? this.receiverRoleRaw,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
      name: name ?? this.name,
      role: role ?? this.role,
      preview: preview ?? this.preview,
      time: time ?? this.time,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final bool isMessageEntity =
        json.containsKey('senderName') || json.containsKey('content');

    final String roleRaw = isMessageEntity
        ? (json['senderRole']?.toString() ??
              json['receiverRole']?.toString() ??
              json['targetRole']?.toString() ??
              '')
        : (json['userRole']?.toString() ?? '');
    final String roleStr = roleRaw.isNotEmpty ? '($roleRaw)' : '';

    String displayTime = '';
    DateTime? parsedSentAt;
    final rawTime = isMessageEntity ? json['sentAt'] : json['lastMessageTime'];
    if (rawTime != null) {
      try {
        final dt = DateTime.parse(rawTime.toString());
        parsedSentAt = dt;
        final now = DateTime.now();
        if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
          displayTime =
              '${dt.hour > 12
                  ? dt.hour - 12
                  : dt.hour == 0
                  ? 12
                  : dt.hour}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}';
        } else {
          displayTime = '${dt.month}/${dt.day}/${dt.year}';
        }
      } catch (e) {
        displayTime = rawTime.toString();
      }
    }

    final String titleName = isMessageEntity
        ? (json['senderName']?.toString() ??
              json['receiverName']?.toString() ??
              (json['isGroupMessage'] == true ? 'Group Message' : 'Unknown'))
        : (json['userName']?.toString() ?? 'Unknown');

    final String previewText = isMessageEntity
        ? (json['content']?.toString() ?? json['subject']?.toString() ?? '')
        : (json['lastMessage']?.toString() ?? '');

    return MessageModel(
      oid: json['oid']?.toString() ?? '',
      senderOid: isMessageEntity
          ? (json['senderOid']?.toString() ?? '')
          : (json['userOid']?.toString() ?? ''),
      senderName: isMessageEntity
          ? (json['senderName']?.toString() ?? '')
          : (json['userName']?.toString() ?? ''),
      senderRoleRaw: isMessageEntity
          ? (json['senderRole']?.toString() ?? '')
          : (json['userRole']?.toString() ?? ''),
      receiverOid: json['receiverOid']?.toString() ?? '',
      receiverName: json['receiverName']?.toString() ?? '',
      receiverRoleRaw: json['receiverRole']?.toString() ?? '',
      content: isMessageEntity
          ? (json['content']?.toString() ?? '')
          : (json['lastMessage']?.toString() ?? ''),
      sentAt: parsedSentAt,
      name: titleName,
      role: roleStr,
      preview: previewText,
      time: displayTime,
      unreadCount: json['unreadCount'] ?? 0,
      isOnline: false,
    );
  }
}
