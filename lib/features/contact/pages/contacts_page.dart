import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';
import 'package:whatsapp_chat_app/common/utils/coloors.dart';
import 'package:whatsapp_chat_app/common/widgets/my_icon_button.dart';
import 'package:whatsapp_chat_app/features/chat/pages/chat_page.dart';
import 'package:whatsapp_chat_app/features/contact/controller/contacts_controller.dart';
import 'package:whatsapp_chat_app/models/user_model.dart';

class ContactsPage extends ConsumerWidget {
  static const String id = 'contacts';
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select contact',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 3),
            ref.watch(getContactsProvider).when(
              data: (data) {
                return Text(
                  '${data[0].length} Contacts',
                  style: const TextStyle(fontSize: 12),
                );
              },
              loading: () {
                return const Text('loading');
              },
              error: (error, trace) {
                log('Something happened');
                return const SizedBox();
              },
            ),
          ],
        ),
        actions: [
          MyIconButton(
              onTap: () {}, icon: Icons.search, iconColor: Colors.white),
          MyIconButton(
              onTap: () {}, icon: Icons.more_vert, iconColor: Colors.white),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
        data: (contactsList) {
          return ListView.builder(
            itemCount: contactsList[0].length + contactsList[1].length,
            itemBuilder: (context, index) {
              late UserModel positiveContact;
              late UserModel negativeConact;
              if (index >= contactsList[0].length) {
                negativeConact =
                    contactsList[1][index - contactsList[0].length];
              } else {
                positiveContact = contactsList[0][index];
              }
              return index < contactsList[0].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              'Contacts on WhatsApp',
                              style: TextStyle(
                                color: context.color.greyColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ChatPage.id,
                              arguments: positiveContact,
                            );
                          },
                          contentPadding: const EdgeInsets.only(left: 20),
                          dense: true,
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF627884),
                            radius: 20,
                            backgroundImage: positiveContact
                                    .profileImageUrl.isNotEmpty
                                ? NetworkImage(positiveContact.profileImageUrl)
                                : null,
                            child: positiveContact.profileImageUrl.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          title: Text(
                            positiveContact.username,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            'Hey There! I\'m using Whatsapp.',
                            style: TextStyle(
                              color: context.color.greyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (contactsList[0].length == index)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              'Invite to WhatsApp',
                              style: TextStyle(
                                color: context.color.greyColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ListTile(
                          onTap: () async {
                            Uri sms = Uri.parse(
                              "sms:${negativeConact.phoneNumber}?body=Let's chat on WhatsApp! it's a fast, simple, and secure app we can use to message and call each other for free. Get it at https://whatsappme.com/dl/",
                            );
                            if (await launchUrl(sms)) {
                              //app opened
                            } else {
                              //app is not opened
                            }
                          },
                          contentPadding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 20,
                            right: 10,
                          ),
                          dense: true,
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFF627884),
                            radius: 20,
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            negativeConact.username,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          trailing: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                foregroundColor: Coloors.greenDark),
                            child: const Text('INVITE'),
                          ),
                        )
                      ],
                    );
            },
          );
        },
        error: (error, trace) {
          log('Something happened');
          return null;
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(
              color: context.color.authAppbarTextColor,
            ),
          );
        },
      ),
    );
  }
}
