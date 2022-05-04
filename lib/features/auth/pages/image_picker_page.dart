import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';
import 'package:whatsapp_chat_app/common/widgets/my_icon_button.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<Widget> mediaList = [];
  int currentPage = 0;
  int? lastPage;

  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= 0.33) return;
    if (currentPage == lastPage) return;
    fetchAllImages();
  }

  fetchAllImages() async {
    lastPage = currentPage;
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );
    List<AssetEntity> photos = await albums[0].getAssetListPaged(page: currentPage, size: 24);
    List<Widget> temp = [];
    for (var asset in photos) {
      temp.add(
        FutureBuilder(
          future: asset.thumbnailDataWithSize(
            const ThumbnailSize(200, 200),
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(snapshot.data),
                  borderRadius: BorderRadius.circular(5),
                  splashFactory: NoSplash.splashFactory,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.color.greyColor!.withOpacity(0.4),
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: MemoryImage(snapshot.data as Uint8List),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      );
    }
    setState(() {
      mediaList.addAll(temp);
      currentPage++;
    });
  }

  @override
  void initState() {
    fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'WhatsApp',
          style: TextStyle(color: context.color.authAppbarTextColor),
        ),
        actions: [
          MyIconButton(
            onTap: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          handleScrollEvent(scroll);
          return true;
        },
        child: GridView.builder(
          itemCount: mediaList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (_, index) {
            return mediaList[index];
          },
        ),
      ),
    );
  }
}
