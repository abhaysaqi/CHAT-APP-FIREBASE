import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/services/chat/chat_service.dart';
import 'package:chat_app_firebase/utils/components/chat_bubble.dart';
import 'package:chat_app_firebase/utils/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ChatScreen extends StatefulWidget {
  final String recieverEmail;
  final String recieverId;
  const ChatScreen(
      {super.key, required this.recieverEmail, required this.recieverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  // for text field focus
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // add listner to focus node
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    // wait a bit for build listview when scroll to bottom
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  // send message
  void sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      // send message
      await _chatService.sendMessage(
          recieverId: widget.recieverId,
          message: _messageController.text.trim());

      // clear message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        title: Text(widget.recieverEmail),
        centerTitle: true,
      ),
      body: Column(
          children: [Expanded(child: _buildMessageList()), _buildUserInput()]),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(
          userId: widget.recieverId, otherUserId: senderId),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: snapshot.error.toString());
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.black,
              semanticsLabel: "loading",
            ),
          );
        }

        //return listview
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var data = snapshot.data!.docs;
              final userId = data[index].data() as Map<String, dynamic>;
              // build message item
              // is current user
              bool isCurrentUser = data[index]['senderId'] == senderId;
              var alignment =
                  isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
              return Container(
                  alignment: alignment,
                  child: Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      ChatBubble(
                          message: data[index]['message'],
                          isCurrentUser: isCurrentUser,
                          messageId: data[index].id,
                          userId: userId['senderId']),
                    ],
                  ));
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.none) {
          const Text("Error in connection");
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: MytextField(
            hintext: "Type a message",
            ishide: false,
            controller: _messageController,
            focusNode: focusNode,
          ),
        )),
        Container(
          margin: const EdgeInsets.only(right: 20, bottom: 20),
          decoration:
              const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
