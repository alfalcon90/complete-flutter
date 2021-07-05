import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReplyBox extends HookWidget {
  const ReplyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enteredMessage = useState('');
    final textController = useTextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                enteredMessage.value = value;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: enteredMessage.value.trim().isEmpty
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    FirebaseFirestore.instance.collection('chat').add({
                      'text': enteredMessage.value,
                      'createdAt': Timestamp.now(),
                      'userId': FirebaseAuth.instance.currentUser?.uid,
                      'username':
                          FirebaseAuth.instance.currentUser?.displayName,
                      'photoUrl': FirebaseAuth.instance.currentUser?.photoURL
                    });
                    textController.clear();
                  },
          )
        ],
      ),
    );
  }
}
