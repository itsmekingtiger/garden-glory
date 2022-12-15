import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AppBar MyAppBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    // backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () => Scaffold.of(context).openDrawer(),
    ),
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
    ],
  );
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              Navigator.of(context).popAndPushNamed('/main');
              break;
            case 1:
              Navigator.of(context).popAndPushNamed('/plants');
              break;
            // case 2:
            //   Navigator.of(context).popAndPushNamed('/main');
            //   break;
            default:
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.mail_rounded), label: '홈'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.tree), label: '내 식물'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar), label: '캘린더'),
        ]);
  }
}
