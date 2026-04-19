import 'package:flutter/material.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';
import 'package:school_system/core/utils/theme_manager.dart';
import 'package:school_system/core/widgets/messages/chat/data/chat_repo.dart';
import 'package:school_system/core/widgets/messages/message_model.dart';
import 'models/chat_message_model.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input_field.dart';
import 'widgets/date_separator.dart';
import 'package:file_picker/file_picker.dart';

class ChatViewBody extends StatefulWidget {
  final MessageModel? conversation;

  const ChatViewBody({super.key, this.conversation});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final ScrollController _scrollController = ScrollController();
  final ChatRepo _chatRepo = ChatRepo();
  bool _isLoading = true;
  String? _errorMessage;

  final List<ChatMessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadThread();
  }

  Future<void> _loadThread() async {
    final currentUserOid = (SharedPrefsHelper.userId ?? '').trim();
    final otherUserOid = (widget.conversation?.senderOid ?? '').trim();

    if (currentUserOid.isEmpty || otherUserOid.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to open chat. Missing user data.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final thread = await _chatRepo.fetchThread(
        currentUserOid: currentUserOid,
        otherUserOid: otherUserOid,
      );

      setState(() {
        _messages
          ..clear()
          ..addAll(
            thread.map((message) {
              final dt = message.sentAt;
              final hour = dt?.hour ?? 0;
              final minute = dt?.minute ?? 0;
              final displayHour = hour == 0
                  ? 12
                  : hour > 12
                  ? hour - 12
                  : hour;
              final suffix = hour >= 12 ? 'PM' : 'AM';
              final formattedTime =
                  '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $suffix';

              return ChatMessageModel(
                text: message.content,
                time: formattedTime,
                isSender: message.senderOid == currentUserOid,
              );
            }),
          );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  void _sendMessage(String text, {PlatformFile? attachedFile}) {
    _sendMessageAsync(text, attachedFile: attachedFile);
  }

  Future<void> _sendMessageAsync(String text, {PlatformFile? attachedFile}) async {
    bool isImage = false;
    if (attachedFile != null) {
      isImage = [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'webp',
      ].contains(attachedFile.extension?.toLowerCase());
    }

    final receiverOid = (widget.conversation?.senderOid ?? '').trim();
    if (receiverOid.isEmpty) {
      return;
    }

    final content = text.isNotEmpty
        ? text
        : (attachedFile != null ? 'Attachment: ${attachedFile.name}' : '');
    if (content.isEmpty) {
      return;
    }

    final tempMessage = ChatMessageModel(
      text: content,
      time: TimeOfDay.now().format(context),
      isSender: true,
      attachedFileName: attachedFile?.name,
      attachedFilePath: attachedFile?.path,
      imageUrl: isImage ? attachedFile?.path : null,
    );

    setState(() {
      _messages.add(tempMessage);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    try {
      await _chatRepo.sendMessage(
        receiverOid: receiverOid,
        subject: widget.conversation?.preview.isNotEmpty == true
            ? widget.conversation!.preview
            : 'Message',
        content: content,
      );
      await _loadThread();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            color: ThemeManager.isDarkMode
                ? const Color(0xff0F172A)
                : const Color(0xffF8FAFC),
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 24),
              children: [
                const DateSeparator(dateText: 'TODAY'),
                const SizedBox(height: 24),
                ..._messages.map((msg) => ChatBubble(message: msg)),
              ],
            ),
          ),
        ),
        ChatInputField(onSendMessage: _sendMessage),
      ],
    );
  }
}
