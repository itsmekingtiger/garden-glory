// ignore_for_file: non_constant_identifier_names

import 'package:brown_brown/views/plants_page.dart';
import 'package:brown_brown/views/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar SubPageAppBar(BuildContext context, String title, {List<Widget>? actions}) {
  return AppBar(
    elevation: 0,
    // backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: actions,
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

/// Button to use with [Scaffold.bottomSheet],
/// deal with home indicator of iOS to add padding.
///
/// If don't want button be floating when software keyboard is showing,
/// set [Scaffold.resizeToAvoidBottomInset] to `false`.
///
/// To make this button floating, there are two way.
///   - passing [BuildContext] directly to this widget.
///   - use "double scaffold".
///
/// To use double scaffold, you need to wrap this widget with two [Scaffold].
///
/// Outter scaffold should have `resizeToAvoidBottomInset` set to `true`.
/// It will resize the body to avoid the keyboard,
/// and at the same time, **_IT WILL MODIFY THE `viewInsets.bottom` TO ZERO_**.
///
/// Inner scaffold should have `resizeToAvoidBottomInset` set to `false`.
/// It will not resize the body to avoid the keyboard.
///
/// If we use only one scaffold and if it has `resizeToAvoidBottomInset` set to `true`,
/// Button can not have bottom padding, because `viewInsets.bottom` is zero.
///
/// If we use only one scaffold and if it has `resizeToAvoidBottomInset` set to `false`,
/// the button can not be floating.
///
/// ```dart
/// Scaffold(
///      resizeToAvoidBottomInset: true,
///      body: Scaffold(
///        resizeToAvoidBottomInset: false,
///        body: body,
///        bottomSheet: BottomSheetButton(),
///      ),
///    )
/// ```
///
class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom * 0.5;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

// Software keyboard 등을 숨기기위해
class Unfocusable extends StatelessWidget {
  const Unfocusable({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
