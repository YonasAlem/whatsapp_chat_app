import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/common/theme/dark_theme.dart';
import 'package:whatsapp_chat_app/common/theme/light_theme.dart';
import 'package:whatsapp_chat_app/features/welcome/pages/welcome_page.dart';
import 'package:whatsapp_chat_app/firebase_options.dart';
import 'package:whatsapp_chat_app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: const WelcomePage(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
