import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/common/widgets/my_icon_button.dart';
import 'package:whatsapp_chat_app/features/home/pages/call_home_page.dart';
import 'package:whatsapp_chat_app/features/home/pages/chat_home_page.dart';
import 'package:whatsapp_chat_app/features/home/pages/status_home_page.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(letterSpacing: 1),
          ),
          elevation: 1,
          actions: [
            MyIconButton(onTap: () {}, icon: Icons.search),
            MyIconButton(onTap: () {}, icon: Icons.more_vert),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatHomePage(),
            StatusHomePage(),
            CallHomePage(),
          ],
        ),
      ),
    );
  }
}
