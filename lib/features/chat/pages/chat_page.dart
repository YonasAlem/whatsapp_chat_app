import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/common/widgets/my_icon_button.dart';
import 'package:whatsapp_chat_app/features/auth/controllers/auth_controller.dart';

import '../../../models/user_model.dart';

class ChatPage extends ConsumerWidget {
  static const String id = 'chat';
  const ChatPage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back),
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(user.profileImageUrl),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.username,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            StreamBuilder(
              stream: ref
                  .read(authControllerProvider)
                  .getUserOnlineStatus(user.uid),
              builder: (_, snapshot) {
                // if (snapshot.connectionState != ConnectionState.active) {
                //   return const Text(
                //     'Connecting...',
                //     style: TextStyle(fontSize: 13),
                //   );
                // }

                final userModel = snapshot.data!;
                DateTime lastSeen = DateTime.fromMillisecondsSinceEpoch(
                  userModel.lastSeen,
                );
                DateTime currentDateTime = DateTime.now();
                Duration differenceDuration =
                    currentDateTime.difference(lastSeen);

                String durationString = differenceDuration.inSeconds > 59
                    ? differenceDuration.inMinutes > 59
                        ? differenceDuration.inHours > 23
                            ? '${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day' : 'days'}'
                            : '${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour' : 'hours'}'
                        : '${differenceDuration.inMinutes} ${differenceDuration.inMinutes == 1 ? 'minute' : 'minutes'}'
                    : 'few moments';
                return Text(
                  userModel.active ? 'Online' : '$durationString ago',
                  style: TextStyle(
                    color: userModel.active ? Colors.green : Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          MyIconButton(
            onTap: () {},
            icon: Icons.video_call,
            iconColor: Colors.white,
          ),
          MyIconButton(
            onTap: () {},
            icon: Icons.call,
            iconColor: Colors.white,
          ),
          MyIconButton(
            onTap: () {},
            icon: Icons.more_vert,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
