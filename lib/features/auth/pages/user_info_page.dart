import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';
import 'package:whatsapp_chat_app/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_chat_app/common/utils/coloors.dart';
import 'package:whatsapp_chat_app/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_chat_app/common/widgets/my_icon_button.dart';
import 'package:whatsapp_chat_app/common/widgets/short_h_bar.dart';
import 'package:whatsapp_chat_app/features/auth/pages/image_picker_page.dart';
import 'package:whatsapp_chat_app/features/auth/widgets/custom_text_field.dart';

class UserInfoPage extends StatefulWidget {
  static const String id = 'user-info';
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  openImagePickerBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShortHBar(),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  'Profile photo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (imageCamera != null || imageGallery != null)
                  MyIconButton(
                    onTap: () {
                      setState(() {
                        imageCamera = null;
                        imageGallery = null;
                      });
                      Navigator.pop(context);
                    },
                    icon: Icons.delete,
                  ),
                MyIconButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                const SizedBox(width: 15),
              ],
            ),
            Divider(
              color: context.color.greyColor!.withOpacity(0.3),
              thickness: 0.5,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 20),
                buildImagePickerIcon(() async {
                  await pickImageFromCamera();
                  if (!mounted) return;
                  Navigator.pop(context);
                }, Icons.camera_alt_rounded, 'Camera'),
                const SizedBox(width: 20),
                buildImagePickerIcon(() async {
                  Navigator.pop(context);
                  final image = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ImagePickerPage(),
                    ),
                  );
                  if (image == null) return;
                  setState(() {
                    imageGallery = image;
                    imageCamera = null;
                  });
                }, Icons.photo_camera_back_rounded, 'Gallery'),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  Column buildImagePickerIcon(
    VoidCallback onTap,
    IconData iconData,
    String text,
  ) {
    return Column(
      children: [
        MyIconButton(
          onTap: onTap,
          icon: iconData,
          iconColor: Coloors.greenDark,
          minWidth: 50,
          border: Border.all(
            color: context.color.greyColor!.withOpacity(0.2),
            width: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(color: context.color.greyColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Profile info',
          style: TextStyle(color: context.color.authAppbarTextColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Please provide your name and an optional profile photo',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.color.greyColor),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: openImagePickerBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: imageGallery == null
                        ? Colors.transparent
                        : context.color.greyColor!.withOpacity(0.4),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.color.photoIconBgColor,
                    image: imageGallery != null || imageCamera != null
                        ? DecorationImage(
                            image: imageGallery != null
                                ? MemoryImage(imageGallery!) as ImageProvider
                                : FileImage(imageCamera!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3, right: 3),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 48,
                      color: imageGallery == null && imageCamera == null
                          ? context.color.photoIconColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                const Expanded(
                  child: CustomTextField(
                    hintText: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.emoji_emotions_outlined, color: context.color.photoIconColor),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: () {},
        text: 'NEXT',
        buttonWidth: 90,
      ),
    );
  }
}
