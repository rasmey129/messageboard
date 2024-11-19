import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  final String boardId;
  ChatScreen({required this.boardId});
  final messageController = TextEditingController();

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('message_boards')
          .doc(boardId)
          .collection('messages')
          .add({
        'message': messageController.text,
        'username': user?.displayName ?? 'Anonymous',
        'senderUid': user?.uid,  
        'timestamp': Timestamp.now(),
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('message_boards')
              .doc(boardId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }
            if (snapshot.hasError) {
              return Text('Error loading room name');
            }
            if (snapshot.hasData && snapshot.data != null) {
              var boardData = snapshot.data!.data() as Map<String, dynamic>;
              return Text(boardData['name'] ?? 'Unknown Room'); 
            } else {
              return Text('Room not found');
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('message_boards')
                  .doc(boardId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data() as Map<String, dynamic>;
                    final isCurrentUser = currentUser?.uid == message['senderUid'];
                    final timestamp = message['timestamp'] as Timestamp;
                    final date = timestamp.toDate();
                    final timeString = DateFormat('HH:mm').format(date);

                    return Align(
                      alignment: isCurrentUser 
                          ? Alignment.centerRight 
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: isCurrentUser 
                              ? CrossAxisAlignment.end 
                              : CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              message['username'] ?? 'Anonymous',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(message['message']),
                            SizedBox(height: 2),
                            Text(
                              timeString,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
