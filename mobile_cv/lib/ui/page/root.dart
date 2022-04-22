import 'package:common/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_cv/service/notification_service.dart';
import 'package:mobile_cv/ui/page/chat.dart';
import 'package:mobile_cv/ui/page/home.dart';
import 'package:mobile_cv/ui/page/login.dart';
import 'package:mobile_cv/ui/widget/menu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Root extends ConsumerStatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  ConsumerState<Root> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  int initalTab = 0;
  @override
  void initState() {
    super.initState();
    ref.read(notificationService).createNotificationChannel();
    ref.read(notificationService).initializeLocalNotifications((p0) {
      setState(() {
        initalTab = 1;
      });
    });

    getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        ref
            .read(notificationService)
            .showNotification(notification.hashCode, notification.title ?? "", notification.body ?? "");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        setState(() {
          initalTab = 1;
        });
      }
    });
  }

  void getInitialMessage() async {
    await FirebaseMessaging.instance.getInitialMessage();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangesProvider).when(data: (user) {
      if (user == null) {
        return const LoginPage();
      }
      return _MenuRoot(initalTab: initalTab);
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
  final int initalTab;
  const _MenuRoot({
    Key? key,
    this.initalTab = 0,
  }) : super(key: key);

  @override
  ConsumerState<_MenuRoot> createState() => _MenuRootState();
}

class _MenuRootState extends ConsumerState<_MenuRoot> {
  int selectedTab = 0;
  @override
  void initState() {
    selectedTab = widget.initalTab;
    super.initState();
    ref.read(authenticationLogic.notifier).getUser();
  }

  @override
  void didUpdateWidget(covariant _MenuRoot oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      selectedTab = widget.initalTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authenticationLogic).currentUser;
    return MenuWidget(
      selectedMenu: selectedTab,
      menuitems: [
        MenuItem(name: "Home", icon: Icons.home),
        MenuItem(
          name: "Üzenetek",
          icon: Icons.chat_bubble,
        ),
      ],
      onChange: (currentTab) {
        setState(() {
          selectedTab = currentTab;
        });
      },
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
