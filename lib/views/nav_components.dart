// ignore_for_file: non_constant_identifier_names

import 'package:brown_brown/views/main_page.dart';
import 'package:brown_brown/views/plants_page.dart';
import 'package:brown_brown/views/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return NavigationBar(
      selectedIndex: currentIndex,
      destinations: [
        NavigationDestination(icon: Icon(CupertinoIcons.sparkles), label: '홈'),
        NavigationDestination(icon: Icon(CupertinoIcons.tree), label: '내 식물'),
        NavigationDestination(icon: Icon(CupertinoIcons.calendar), label: '캘린더'),
      ],
      onDestinationSelected: (value) => {
        if (value == 0)
          {
            Navigator.of(context).pushReplacementNamed(RootPage.pageUrl),
          }
        else if (value == 1)
          {
            Navigator.of(context).pushReplacementNamed(PlantsPage.pageUrl),
          }
        else if (value == 2)
          {
            Navigator.of(context).pushReplacementNamed(PlantsPage.pageUrl),
          }
      },
    );
  }
}
