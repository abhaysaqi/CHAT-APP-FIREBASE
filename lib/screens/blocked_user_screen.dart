import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/services/chat/chat_service.dart';
import 'package:chat_app_firebase/utils/components/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class BlockedUserScreen extends StatelessWidget {
  BlockedUserScreen({super.key});

  // chat & auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  // show confirm unblock box
  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Unblock User"),
          content: const Text("Are you sure you want to unblock this user?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  chatService.unblockUser(userId);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User Unblocked")));
                },
                child: const Text("Unblock")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String userId = authService.getCurrentUser()!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLOCKED USERS "),
        centerTitle: true,
        actions: const [],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUserStream(userId),
        builder: (context, snapshot) {
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

          final blockedUsers = snapshot.data ?? [];

          if (blockedUsers.isEmpty || blockedUsers.isEmpty) {
            return const Center(child: Text("No blocked users"));
          }
          //return listview
          if (snapshot.connectionState == ConnectionState.active &&
              blockedUsers.isNotEmpty) {
            return ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (BuildContext context, int index) {
                final user = blockedUsers[index];
                return UserTile(
                    text: user['email'],
                    ontap: () => _showUnblockBox(context, user['uid']));
                // String email = snapshot.data![index]['email'];
                // String UserId = snapshot.data![index]['uid'];
                // if (email != _authService.getCurrentUser()!.email) {
                //   return UserTile(
                //       text: email,
                //       ontap: () => Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => ChatScreen(
                //                     recieverEmail: email,
                //                     recieverId: UserId,
                //                   ))));
                // }

                // return Container();
              },
            );
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
