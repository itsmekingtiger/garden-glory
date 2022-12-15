import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/views/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: MyAppBar(context, "홈"),
      body: Column(
        children: [
          // Watering Notification Section
          Text('물주기를 기다리고 있어요', style: TextStyle(fontSize: 20)),

          // Long time no see section
        ],
      ),
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
