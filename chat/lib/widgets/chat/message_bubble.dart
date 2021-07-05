import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final String username;
  final String photoUrl;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.isUser,
    required this.username,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: isUser
                        ? Theme.of(context).accentColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft:
                          isUser ? Radius.circular(12) : Radius.circular(4),
                      bottomRight:
                          isUser ? Radius.circular(4) : Radius.circular(12),
                    ),
                  ),
                  // width: 140,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    text,
                    style:
                        TextStyle(color: isUser ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          ),
        ],
      ),
    );
  }
}
