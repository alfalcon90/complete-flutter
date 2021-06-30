import 'dart:async';
import 'package:chat/controllers/auth_controller.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded<Future<void>>(() async {
    runApp(ProviderScope(child: MyApp()));
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);

    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
      ],
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: authControllerState != null ? HomeScreen() : AuthScreen(),
    );
  }
}
