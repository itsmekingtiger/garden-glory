import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.mail_rounded), label: '홈'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.tree), label: '내 식물'),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar), label: '캘린더'),
      ]),
      body: Column(
        children: [
          // watering notification and quick access
          // WateringNotificationSection(),
        ],
      ),
    );
  }
}
