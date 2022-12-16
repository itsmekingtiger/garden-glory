// ignore_for_file: non_constant_identifier_names

import 'package:brown_brown/views/main_page.dart';
import 'package:brown_brown/views/plants_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AppBar TopLevelAppBar(BuildContext context, String title) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,

    // Open drawer
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),

    // TODO: App logo
    title: Text(title, style: Theme.of(context).textTheme.headline4),
  );
}

AppBar SubPageAppBar(BuildContext context, String title) {
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
              Navigator.of(context).popAndPushNamed(MainPage.pageUrl);
              break;
            case 1:
              Navigator.of(context).popAndPushNamed(PlantsPage.pageUrl);
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
