import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mt_task_alabtechnology/models/post_model.dart';
import 'package:mt_task_alabtechnology/providers/post_provider.dart';
import 'package:mt_task_alabtechnology/screens/login_screen.dart';
import 'package:provider/provider.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());

  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    String? token = await messaging.getToken();
    log('FCM Token: $token');
  }catch(e) {
    log('Not initialized');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider())
      ],
      child: MaterialApp(
        title: 'MT_Task_Alabtechnology',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent)
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen()
      ),
    );
  }
}

