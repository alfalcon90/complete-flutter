import 'package:chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Thread extends StatelessWidget {
  const Thread({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              reverse: true,
              itemCount: snapshot.data?.size,
              itemBuilder: (ctx, i) {
                var doc = snapshot.data?.docs[i];
                bool isUser =
                    FirebaseAuth.instance.currentUser?.uid == doc?['userId'];
                return MessageBubble(
                    key: ValueKey(doc?.id),
                    text: doc?['text'],
                    isUser: isUser,
                    username: doc?['username'],
                    photoUrl: doc?['photoUrl']);
              });
        });
  }
}
