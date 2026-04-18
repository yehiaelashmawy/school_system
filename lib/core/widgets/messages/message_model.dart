class MessageModel {
  final String name;
  final String role; // e.g. "(Parent)" or "(Student)"
  final String preview;
  final String time;
  final int unreadCount;
  final bool isOnline;

  const MessageModel({
    required this.name,
    required this.role,
    required this.preview,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final String roleRaw = json['userRole']?.toString() ?? '';
    final String roleStr = roleRaw.isNotEmpty ? '($roleRaw)' : '';

    String displayTime = '';
    if (json['lastMessageTime'] != null) {
      try {
        final dt = DateTime.parse(json['lastMessageTime']);
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
        displayTime = json['lastMessageTime'].toString();
      }
    }

    return MessageModel(
      name: json['userName']?.toString() ?? 'Unknown',
      role: roleStr,
      preview: json['lastMessage']?.toString() ?? '',
      time: displayTime,
      unreadCount: json['unreadCount'] ?? 0,
      isOnline: false,
    );
  }
}
