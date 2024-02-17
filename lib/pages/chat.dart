import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _curUser = ChatUser(id: "1", firstName: "Sarah");
    _gptUser = ChatUser(id: "2", firstName: "WITT");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(0);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: DashChat(
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
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF45757B),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              duration: const Duration(
                milliseconds: 400,
              ),
              tabBackgroundColor: Colors.white,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.question_answer_rounded,
                  text: 'Chat',
                ),
                GButton(
                  icon: Icons.camera_rounded,
                  text: 'Camera',
                ),
                GButton(
                  icon: Icons.person_outline_rounded,
                  text: 'My Page',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                navigateTo(index);
              },
            ),
          ),
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

  void navigateTo(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
      case 1:
        Navigator.pushNamed(context, '/search').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
      case 2:
        Navigator.pushNamed(context, '/camera').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
      case 3:
        Navigator.pushNamed(context, '/mypage').then((value) => {
              setState(() {
                _selectedIndex = value as int;
              })
            });
        break;
    }
  }
}
