import 'dart:math';

import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/profile_logic.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/ui/widget/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/ui/widget/chat_bubble.dart';
import 'package:common/logic/chat_logic.dart';
import 'package:common/ui/widget/typing_indicator.dart';
import 'package:common/ui/widget/picture_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:common/logic/image_logic.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await WidgetsBinding.instance?.endOfFrame;
      stream();
    });
    super.initState();
  }

  void stream() async {
    await ref.read(chatLogic.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(chatLogic).chats;
    final uId = ref.watch(authenticationLogic).userId;
    final profile = ref.watch(profileLogic).profile;
    final isTyping = ref.watch(chatLogic).isTyping;
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.name),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 10, 13, 0),
                itemCount: chats.length,
                reverse: true,
                itemBuilder: (c, i) {
                  return ListItem(chat: chats[i], uId: uId);
                }),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TypingIndicator(
              bubbleColor: Colors.grey[300]!,
              flashingCircleDarkColor: Colors.grey,
              showIndicator: isTyping,
            ),
          ),
          const BottomBar(),
        ],
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  final Profile profile;
  const EmptyWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                profile.profile,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(profile.name, style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 40),
            const Text(
              "Ha tetszik a munkám és meggyőztem. Küldjön nekem üzenetet!",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends ConsumerWidget {
  final Chat chat;
  final String uId;
  const ListItem({
    Key? key,
    required this.chat,
    required this.uId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double maxWidth = MediaQuery.of(context).size.width / 1.65;
    if (chat.isPicture) {
      final uploadState = ref.watch(imageLogic(chat.id)).image;
      return PictureBubble(
        isSender: uId == chat.sender,
        picture: chat.picture,
        isShowIndicator: uploadState.state == TaskState.running,
        progress: uploadState.progress,
        isSaw: chat.isSee,
        onTap: () {},
        maxWidth: maxWidth,
      );
    }
    return ChatBubble(
      maxWidth: maxWidth,
      isSender: uId == chat.sender,
      message: chat.message,
      isSaw: chat.isSee,
      isShowIndicator: !chat.isUpload,
      onLongPress: () {},
    );
  }
}

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  late TextEditingController controller;
  late ImagePicker picker;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    picker = ImagePicker();
    controller.addListener(() => textListener());
  }

  @override
  void dispose() {
    controller.removeListener(() => textListener());
    controller.dispose();
    super.dispose();
  }

  void textListener() {
    if (controller.text.isNotEmpty) {
      ref.read(chatLogic.notifier).typingStatus(true);
    } else {
      ref.read(chatLogic.notifier).typingStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uId = ref.watch(authenticationLogic).userId;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              final image = await picker.pickImage(source: ImageSource.camera);
              final ran = Random();
              final id = "${uId.substring(0, 5)}-${ran.nextInt(13402)}-${image!.name.split('.').first}";
              ref.read(imageLogic(id).notifier).getImage(image);
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 35,
            ),
          ),
          InkWell(
            onTap: () async {
              final image = await picker.pickMultiImage();
              image?.forEach((element) {
                final ran = Random();
                final id = "${uId.substring(0, 5)}-${ran.nextInt(13402)}-${element.name.split('.').first}";
                ref.read(imageLogic(id).notifier).getImage(element);
              });
            },
            child: const Icon(
              Icons.image,
              color: Colors.blue,
              size: 35,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Text",
                counterText: "",
              ),
              maxLines: null,
              maxLength: 1000,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: 10),
          CircleButton(
            onTap: () async {
              if (controller.text.isNotEmpty) {
                ref.read(chatLogic.notifier).sendMessage(controller.text);
                controller.text = "";
              }
            },
            icon: Icons.send_rounded,
            color: Colors.blue,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
