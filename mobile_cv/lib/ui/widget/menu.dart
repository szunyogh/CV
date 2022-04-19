import 'package:common/ui/theme/theme.dart';
import 'package:common/ui/widget/custom_button.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final IconData icon;
  final Color color;
  MenuItem({required this.name, required this.icon, this.color = Colors.black});
}

class MenuHeader {
  final String profilePic;
  final String name;
  final String email;
  MenuHeader({
    required this.profilePic,
    required this.name,
    required this.email,
  });
}

class MenuWidget extends StatefulWidget {
  final int selectedMenu;
  final Function(int) onChange;
  final List<MenuItem> menuitems;
  final List<Widget> pages;
  final MenuHeader header;
  final Function()? logout;
  const MenuWidget({
    Key? key,
    required this.selectedMenu,
    required this.menuitems,
    required this.onChange,
    required this.pages,
    required this.header,
    this.logout,
  }) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          IndexedStack(
            index: widget.selectedMenu,
            children: widget.pages,
          ),
          Positioned(
            left: 10,
            top: 40,
            child: InkWell(
              onTap: () {
                if (!_scaffoldKey.currentState!.isDrawerOpen) {
                  _scaffoldKey.currentState!.openDrawer();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(23), color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      widget.header.profilePic,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey,
                        );
                      },
                      loadingBuilder: (c, child, loading) {
                        if (loading == null) return child;
                        return Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(widget.header.name),
              const SizedBox(height: 10),
              Text(widget.header.email),
              const SizedBox(height: 20),
              ...widget.menuitems.map((e) {
                int index = widget.menuitems.indexWhere((element) => element == e);
                return InkWell(
                  onTap: () {
                    widget.onChange(index);
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: widget.selectedMenu == index ? blueColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          e.icon,
                          color: widget.selectedMenu == index ? Colors.white : e.color,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e.name,
                          style: TextStyle(
                            color: widget.selectedMenu == index ? Colors.white : e.color,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              const Spacer(),
              if (widget.logout != null)
                Center(
                  child: CustomButton.primary(
                    child: const Text('Logout'),
                    onTap: () {
                      widget.logout!();
                    },
                    width: 100,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
