import 'package:chat/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Chat'),
            leading: IconButton(
                onPressed: () =>
                    context.read(authControllerProvider.notifier).signOut(),
                icon: const Icon(Icons.logout))),
      ),
    );
  }
}
