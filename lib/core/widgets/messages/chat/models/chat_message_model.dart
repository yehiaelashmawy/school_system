class ChatMessageModel {
  final String text;
  final String time;
  final bool isSender;
  final String? imageUrl;
  final String? avatarUrl;
  final String? attachedFileName;
  final String? attachedFilePath;

  const ChatMessageModel({
    required this.text,
    required this.time,
    this.isSender = false,
    this.imageUrl,
    this.avatarUrl,
    this.attachedFileName,
    this.attachedFilePath,
  });
}
