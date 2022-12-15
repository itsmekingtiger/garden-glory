import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AppBar MyAppBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    // backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(title),
  );
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
    this.currentIndex, {
    Key? key,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
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
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(CupertinoIcons.sparkles), label: '홈'),
          const BottomNavigationBarItem(icon: Icon(CupertinoIcons.tree), label: '내 식물'),
          const BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar), label: '캘린더'),
        ]);
  }
}
