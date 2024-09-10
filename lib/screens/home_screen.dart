import 'package:chat_app_firebase/screens/chat_screen.dart';
import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/services/chat/chat_service.dart';
import 'package:chat_app_firebase/utils/components/drawer.dart';
import 'package:chat_app_firebase/utils/components/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    final auth = AuthService();
    auth.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        title: const Text("USERS"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                logout();
                Navigator.pushReplacementNamed(context, '/signin');
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStreamExcludingBlocked(),
      // initialData: initialData,
      builder: (BuildContext context, snapshot) {
        //error
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
        //return listview
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              String email = snapshot.data![index]['email'];
              String UserId = snapshot.data![index]['uid'];
              if (email != _authService.getCurrentUser()!.email) {
                return UserTile(
                    text: email,
                    ontap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  recieverEmail: email,
                                  recieverId: UserId,
                                ))));
              }

              return Container();
            },
          );
        }
        if (blockedUsers.isEmpty) {
          return const Center(
            child: Text("data"),
          );
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}
