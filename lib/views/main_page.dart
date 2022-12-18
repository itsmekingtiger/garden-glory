import 'dart:ui';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  static const pageUrl = '/main';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: TopLevelAppBar(context, 'Garden Glory'),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Text('Drawer Header'),
                ),
                ListTile(title: Text('설정'), onTap: () {}),
                ListTile(title: Text('로그'), onTap: () {}),

                // Import and Export
              ],
            ),

            // Server Client State
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Watering Notification Section
            Text('물주기를 기다리고 있어요', style: TextStyle(fontSize: 20)),

            // Long time no see section
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(0),
    );
  }
}

// class WateringNotificationSection extends StatelessWidget {
//   const WateringNotificationSection(int plantId, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return PlantCard(plantId: index);
//         },
//       ),
//     );
//   }
// }
