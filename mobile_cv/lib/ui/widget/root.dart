import 'package:common/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_cv/ui/page/chat.dart';
import 'package:mobile_cv/ui/page/home.dart';
import 'package:mobile_cv/ui/page/login.dart';
import 'package:mobile_cv/ui/widget/menu.dart';

class RootWidget extends ConsumerWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangesProvider).when(data: (user) {
      if (user == null) {
        return const LoginPage();
      }
      return const _MenuRoot();
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
  const _MenuRoot({Key? key}) : super(key: key);

  @override
  ConsumerState<_MenuRoot> createState() => _MenuRootState();
}

class _MenuRootState extends ConsumerState<_MenuRoot> {
  int selectedTab = 0;
  @override
  void initState() {
    super.initState();
    ref.read(authenticationLogic.notifier).getUser();
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
