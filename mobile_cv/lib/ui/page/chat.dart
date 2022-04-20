import 'dart:math';
import 'package:extended_image/extended_image.dart';
import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/profile_logic.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/ui/widget/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/ui/widget/chat_bubble.dart';
import 'package:common/logic/chat_logic.dart';
import 'package:common/ui/widget/typing_indicator.dart';
import 'package:common/ui/widget/picture_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:common/logic/image_logic.dart';
import 'package:mobile_cv/ui/page/photo_view.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      ref.read(chatLogic.notifier).typingStatus(false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    ref.read(chatLogic.notifier).dispose();
    super.dispose();
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
            child: chats.isEmpty
                ? EmptyWidget(profile: profile)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 10, 13, 0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: chats.length,
                    reverse: true,
                    itemBuilder: (c, i) {
                      final sawIndex = chats.indexWhere((val) => val.isSee == true && val.sender == uId);
                      return ListItem(chat: chats[i], isSender: uId == chats[i].sender, isSaw: sawIndex == i);
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
                errorBuilder: (c, o, s) {
                  return Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  );
                },
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
  final bool isSender;
  final bool isSaw;
  const ListItem({
    Key? key,
    required this.chat,
    required this.isSender,
    this.isSaw = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double maxWidth = MediaQuery.of(context).size.width / 1.65;
    if (chat.isPicture) {
      final progress = ref.watch(imageLogic(chat.id)).progress;
      return PictureBubble(
        isSender: isSender,
        picture: chat.picture,
        isShowIndicator: !chat.isUpload,
        progress: progress,
        isSaw: isSaw,
        onTap: () {
          Navigator.of(context).push(_createRoute(PhotoView(picture: chat.picture)));
        },
        maxWidth: maxWidth,
        errorMessage: chat.isUpload ? "Hiba a kép betöltése során" : "A kép feltöltése folyamatban",
      );
    }
    return ChatBubble(
      maxWidth: maxWidth,
      isSender: isSender,
      message: chat.message,
      isSaw: isSaw,
      isShowIndicator: !chat.isUpload,
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: chat.message)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Sikeresen a vágólapra másolva!"),
            ),
          );
        });
      },
    );
  }

  Route _createRoute(Widget child) {
    return PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (BuildContext context, _, __) {
          return child;
        });
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
