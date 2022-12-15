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
          // Create New pant button
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/new_plant'),
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                '식물 추가하기',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Icon(
                              Icons.add,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
