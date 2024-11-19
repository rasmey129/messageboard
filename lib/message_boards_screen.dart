import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBoardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Boards')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('message_boards').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No message boards available.'));
          }

          final boards = snapshot.data!.docs;

          return ListView.builder(
            itemCount: boards.length,
            itemBuilder: (context, index) {
              var board = boards[index];
              return ListTile(
                leading: Icon(Icons.forum),
                title: Text(board['name']),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/chat',
                    arguments: board.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
