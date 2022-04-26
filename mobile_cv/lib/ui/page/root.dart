import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/chat_logic.dart';
import 'package:common/model/state/loader_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_cv/helper/custom_rout.dart';
import 'package:mobile_cv/service/notification_service.dart';
import 'package:mobile_cv/ui/application.dart';
import 'package:mobile_cv/ui/page/chat.dart';
import 'package:mobile_cv/ui/page/home.dart';
import 'package:mobile_cv/ui/page/login.dart';
import 'package:mobile_cv/ui/widget/menu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:common/logic/loader_logic.dart';
import 'package:just_audio/just_audio.dart';

class Root extends ConsumerStatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  ConsumerState<Root> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  int menuIndex = 0;
  bool oneTimeRun = false;
  OverlayEntry? loader;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setAsset('assets/audio/notification.mp3');
    ref.read(notificationService).createNotificationChannel();
    ref.read(notificationService).initializeLocalNotifications((p0) {
      setState(() {
        menuIndex = 1;
      });
    });

    getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      if (notification != null && menuIndex != 1) {
        ref
            .read(notificationService)
            .showNotification(notification.hashCode, notification.title ?? "", notification.body ?? "");
      } else {
        if (player.processingState == ProcessingState.completed) {
          player.seek(Duration.zero);
        } else {
          player.play();
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        setState(() {
          menuIndex = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void getInitialMessage() async {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null && !oneTimeRun) {
      globalNavigatorKey.currentState?.push(
        MyCustomRoute(
          builder: (context) => const ChatPage(initialize: true),
        ),
      );
      oneTimeRun = true;
    }
  }

  void hideloader() {
    loader!.remove();
    loader = null;
  }

  void showLoader(BuildContext _context, String message) {
    OverlayState overlay = Overlay.of(_context)!;

    if (loader == null) {
      loader = OverlayEntry(
        builder: (context) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(height: 10),
                Text(message)
              ],
            ),
          );
        },
      );

      overlay.insert(loader!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangesProvider).when(data: (user) {
      if (user == null) {
        return const LoginPage();
      }
      ref.listen<LoaderState>(loaderLogic, (previous, next) {
        if (next.hide) {
          showLoader(context, next.message);
        } else {
          hideloader();
        }
      });
      return _MenuRoot(
        initalMenuIndex: menuIndex,
        selectedMenu: (value) {
          setState(() {
            menuIndex = value;
          });
        },
      );
    }, error: (error, stackt) {
      return const LoginPage();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class _MenuRoot extends ConsumerStatefulWidget {
  final int initalMenuIndex;
  final Function(int) selectedMenu;
  const _MenuRoot({
    Key? key,
    this.initalMenuIndex = 0,
    required this.selectedMenu,
  }) : super(key: key);

  @override
  ConsumerState<_MenuRoot> createState() => _MenuRootState();
}

class _MenuRootState extends ConsumerState<_MenuRoot> {
  int selectedMenuIndex = 0;
  @override
  void initState() {
    selectedMenuIndex = widget.initalMenuIndex;
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) async {
      await ref.read(authenticationLogic.notifier).initialize();
      ref.read(chatLogic.notifier).getBadge();
    });
  }

  @override
  void didUpdateWidget(covariant _MenuRoot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initalMenuIndex != widget.initalMenuIndex) {
      setState(() {
        selectedMenuIndex = widget.initalMenuIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeCount = ref.watch(chatLogic).badgeCount;
    final user = ref.watch(authenticationLogic).currentUser;
    return MenuWidget(
      selectedMenu: selectedMenuIndex,
      menuitems: [
        MenuItem(name: "Home", icon: Icons.home),
        MenuItem(
          name: "Üzenetek",
          icon: Icons.chat_bubble,
          subWidget: BadgeWidget(badgeCount: badgeCount),
        ),
      ],
      onChange: (currentTab) => widget.selectedMenu(currentTab),
      pages: const [
        HomPage(),
        ChatPage(),
      ],
      header: MenuHeader(
        email: user.email,
        profilePic: user.profilePic,
        name: user.name,
      ),
      logout: () {
        ref.read(authenticationLogic.notifier).logout();
      },
    );
  }
}

class BadgeWidget extends StatelessWidget {
  final int badgeCount;
  const BadgeWidget({
    Key? key,
    required this.badgeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (badgeCount == 0) {
      return Container();
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 30.5),
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
      height: 30.5,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: Text(
        '$badgeCount',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
