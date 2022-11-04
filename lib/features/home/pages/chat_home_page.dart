import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/features/contact/pages/contacts_page.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  navigateToContactsPage(context) {
    Navigator.pushNamed(context, ContactsPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Chat Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToContactsPage(context),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
