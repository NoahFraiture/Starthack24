import 'package:bellcoach/widget/top_bar_custom.dart';
import 'package:dart_openai/dart_openai.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

import "../user.dart";

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final _chatController = TextEditingController();
  final _scrollController = ScrollController(initialScrollOffset: 0);
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarCustom(showBackButton: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildMessageInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    Alignment alignment = Alignment.topLeft;
    Color backgroundColor = Colors.white;

    if (message.isUser) {
      alignment = Alignment.topRight;
      backgroundColor = Theme.of(context).colorScheme.secondary;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser)
            CircleAvatar(
              child: Image.asset(UserCustom.coachIconPath),
            ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              alignment: alignment,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                message.text,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _chatController,
            decoration: const InputDecoration(hintText: 'Type your message...'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () async {
            final Future<String?> response = _sendMessage(_chatController.text);
            setState(() {
              _messages.add(ChatMessage(text: _chatController.text, isUser: true));
              _chatController.clear();
            });
            response.then((value) {
              setState(() => _messages.add(ChatMessage(text: value ?? "error", isUser: false)));
              _scrollController.animateTo(_scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
            });
          },
        ),
      ],
    );
  }

  Future<String?> _sendMessage(String message) async {
    OpenAIChatCompletionModel completion =
        await OpenAI.instance.chat.create(model: "gpt-3.5-turbo-0125", maxTokens: 100, messages: [
      OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(message)])
    ]);
    return completion.choices.first.message.content?.last.text;
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
