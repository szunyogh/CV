import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/file_logic.dart';
import 'package:common/logic/profile_logic.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/ui/widget/circle_button.dart';
import 'package:common/ui/widget/video_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/ui/widget/chat_bubble.dart';
import 'package:common/logic/chat_logic.dart';
import 'package:common/ui/widget/typing_indicator.dart';
import 'package:common/ui/widget/picture_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_cv/ui/page/photo_view.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_cv/ui/page/video_view.dart';
import 'package:mobile_cv/ui/widget/like.dart';
import 'package:mobile_cv/ui/widget/photo_gallery.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class ChatPage extends ConsumerStatefulWidget {
  final bool initialize;
  const ChatPage({
    Key? key,
    this.initialize = false,
  }) : super(key: key);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> with WidgetsBindingObserver {
  StreamSubscription<ConnectivityResult>? connectivityStream;
  StreamSubscription<List<Chat>>? chatListStream;
  StreamSubscription<bool>? typingStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await WidgetsBinding.instance?.endOfFrame;
      connectivityStream = await ref.read(chatLogic.notifier).initialize(initialize: widget.initialize);
      chatListStream = await ref.read(chatLogic.notifier).getMessage();
      typingStream = await ref.read(chatLogic.notifier).getTyping();
    });
    WidgetsBinding.instance?.addObserver(this);
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
    connectivityStream?.cancel();
    chatListStream?.cancel();
    typingStream?.cancel();
    WidgetsBinding.instance?.removeObserver(this);
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
                : GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 10, 13, 0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: chats.length + 1,
                        reverse: true,
                        itemBuilder: (c, i) {
                          final sawIndex = chats.indexWhere((val) => val.isSee == true && val.sender == uId);
                          if (i != 0) {
                            if (chats[i - 1].isPicture || chats[i - 1].isVideo) {
                              ref.read(fileLogic(chats[i - 1].id).notifier).initialize(url: chats[i - 1].file['url'] ?? "");
                              if (chats[i - 1].isVideo) {
                                ref.read(fileLogic(chats[i - 1].id).notifier).videoInitalize();
                              }
                            }
                          }

                          if (i == 0) {
                            return Align(
                              alignment: Alignment.bottomLeft,
                              child: TypingIndicator(
                                bubbleColor: Colors.grey[300]!,
                                flashingCircleDarkColor: Colors.grey,
                                showIndicator: isTyping,
                              ),
                            );
                          }
                          return LikeWidget(
                              enabled: !(uId == chats[i - 1].sender),
                              onChanged: (value) {
                                ref.read(chatLogic.notifier).updateLike(chats[i - 1].id, value);
                              },
                              child: ListItem(
                                chat: chats[i - 1],
                                isSender: uId == chats[i - 1].sender,
                                isSaw: sawIndex == i - 1,
                                onTap: () {
                                  ref.read(chatLogic.notifier).deleteLike(chats[i - 1].id);
                                },
                              ));
                        }),
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
  final Function onTap;
  const ListItem({
    Key? key,
    required this.chat,
    required this.isSender,
    this.isSaw = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double maxWidth = MediaQuery.of(context).size.width / 1.65;
    if (chat.isPicture) {
      final progress = ref.watch(fileLogic(chat.id)).progress;
      final file = ref.watch(fileLogic(chat.id)).file;
      return PhotoView(
        isSender: isSender,
        picture: file,
        indicatorPicture: chat.file['url'] ?? "",
        isShowIndicator: !chat.isUpload,
        progress: progress,
        isSaw: isSaw,
        maxWidth: maxWidth,
        like: chat.like,
        errorMessage: chat.isUpload ? "Hiba a kép betöltése során" : "A kép feltöltése folyamatban",
        onTap: () => onTap(),
      );
    }
    if (chat.isVideo) {
      return VideoView(
        isSender: isSender,
        indicatorPicture: chat.file['url'] ?? "",
        id: chat.id,
        isShowIndicator: !chat.isUpload,
        isSaw: isSaw,
        maxWidth: maxWidth,
        like: chat.like,
        onTap: () => onTap(),
      );
    }
    return ChatBubble(
      maxWidth: maxWidth,
      isSender: isSender,
      message: chat.message,
      isSaw: isSaw,
      isShowIndicator: !chat.isUpload,
      like: chat.like,
      doubleTap: () {
        Clipboard.setData(ClipboardData(text: chat.message)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Sikeresen a vágólapra másolva!"),
            ),
          );
        });
      },
      onTap: () => onTap(),
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
              final id = "${uId.substring(0, 5)}-${ran.nextInt(13402)}-${image!.name}";
              final bytes = await image.readAsBytes();
              ref.read(fileLogic(id).notifier).getFile("image", image.name, base64.encode(bytes), File(image.path));
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 35,
            ),
          ),
          InkWell(
            onTap: () async {
              final files = await bottomSheet();
              files?.forEach((element) async {
                final bytes = await element.thumbnailData;
                final file = await element.file;
                final ran = Random();
                final id = "${uId.substring(0, 5)}-${ran.nextInt(13402)}-${element.title ?? ""}";
                ref
                    .read(fileLogic(id).notifier)
                    .getFile(element.type.name, element.title ?? "", base64.encode(bytes!), file!);
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

  Future<List<AssetEntity>?> bottomSheet() async {
    return await showModalBottomSheet<List<AssetEntity>>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification notification) {
            if (notification.extent <= 0.3) {
              Navigator.maybePop(context);
            }
            return false;
          },
          child: DraggableScrollableSheet(
              expand: false,
              snap: true,
              minChildSize: 0.0,
              snapSizes: const [0.0, 0.5, 1.0],
              builder: (BuildContext context, ScrollController scrollController) {
                return Column(
                  children: [
                    Container(
                      width: 100,
                      height: 8,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: PhotoGallery(
                        controller: scrollController,
                      ),
                    ),
                  ],
                );
              }),
        );
      },
    );
  }
}
