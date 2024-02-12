import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/consts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatUser _curUser;
  late ChatUser _gptUser;
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _curUser = ChatUser(id: "1", firstName: "Sarah");
    _gptUser = ChatUser(id: "2", firstName: "WITT");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
        body: DashChat(
          currentUser: _curUser,
          messageOptions: const MessageOptions(
            currentUserContainerColor: Color(0xFF7DC7BF),
            currentUserTextColor: Color(0xFF292929),
            textColor: Color(0xFF292929),
            timeTextColor: Color(0xFF292929),
            currentUserTimeTextColor: Color(0xFF292929),
            containerColor: Colors.blueGrey,
          ),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages,
        ),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    final openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(
          seconds: 5,
        ),
      ),
      enableLog: true,
    );

    setState(() {
      _messages.insert(0, m);
    });
    List<Map<String, dynamic>> messagesHistory = _messages.reversed.map((m) {
      if (m.user == _curUser) {
        return {'role': 'user', 'content': m.text};
      } else {
        return {'role': 'assistant', 'content': m.text};
      }
    }).toList();
    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: messagesHistory,
      maxToken: 200,
    );
    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(
          () {
            _messages.insert(
              0,
              ChatMessage(
                user: _gptUser,
                createdAt: DateTime.now(),
                text: element.message!.content,
              ),
            );
          },
        );
      }
    }
  }
}
