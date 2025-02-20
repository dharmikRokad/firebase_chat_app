import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/chat_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// FIGMA
// https://www.figma.com/design/SgtwOt0Nq4E2FUbhrqpOcf/Messaging---Chatbox-App-Design-(Community)?node-id=1-4094&node-type=frame&t=ukTXMjof73EYMKgZ-0

// Country - State - City
// https://pub.dev/packages/country_state_city_pro

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  ChatAppInjector().init();

  // SharedPrefs.instance.init();
  // await Supabase.initialize(
  //   anonKey: dotenv.env["SB_ANON_KEY"] ?? '',
  //   url: dotenv.env["SB_PUB_URL"] ?? '',
  // );

  runApp(const ChatApp());
}
