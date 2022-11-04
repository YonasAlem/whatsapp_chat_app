import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/common/theme/dark_theme.dart';
import 'package:whatsapp_chat_app/common/theme/light_theme.dart';
import 'package:whatsapp_chat_app/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp_chat_app/features/home/pages/home_page.dart';
import 'package:whatsapp_chat_app/features/welcome/pages/welcome_page.dart';
import 'package:whatsapp_chat_app/firebase_options.dart';
import 'package:whatsapp_chat_app/routes/routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: ref.watch(userInfoAuthProvider).when(
            data: (user) {
              FlutterNativeSplash.remove();
              if (user == null) return const WelcomePage();
              return const HomePage();
            },
            error: (error, trace) => Scaffold(
              body: Center(
                child: Text("$error"),
              ),
            ),
            loading: () => const SizedBox(),
          ),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
