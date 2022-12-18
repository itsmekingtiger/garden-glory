import 'dart:ui';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:brown_brown/views/plant_detail_page.dart';
import 'package:brown_brown/views/plant_log_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MainPage extends ConsumerWidget {
  static const pageUrl = '/main';

  MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    final List<Plant> needWaterings = ref.watch(needToWateringProvider);

    return SafeArea(
      child: Column(
        children: [
          // Watering Notification Section
          Text('물주기를 기다리고 있어요', style: Theme.of(context).textTheme.headline6),

          ...needWaterings
              .map((plant) => Slidable(
                    endActionPane: ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 1,
                        onPressed: (context) => Navigator.of(context).pushNamed(
                          PlantLogEditPage.pageUrl,
                          arguments: {
                            'plant': plant,
                            'mode': LogEditMode.add,
                          },
                        ),
                        backgroundColor: Color(0xFF386641),
                        foregroundColor: Colors.white,
                        icon: Icons.edit_calendar_rounded,
                        label: '로그',
                      ),
                      SlidableAction(
                        flex: 1,
                        onPressed: (context) {
                          ref.watch(plantListProvider.notifier).addLog(
                                plantId: plant.id,
                                description: '물을 줬어요',
                                tagType: {TagType.watering},
                                createdAt: DateTime.now(),
                              );
                        },
                        backgroundColor: Color(0xFF6a994e),
                        foregroundColor: Colors.white,
                        icon: Icons.water_drop,
                        label: '물주기',
                      ),
                    ]),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: plant.profileImage == null ? null : FileImage(plant.profileImage!),
                      ),
                      visualDensity: VisualDensity.compact,
                      title: Text(plant.name),
                      subtitle: Text('물주기로 예정된 시간: ${dateAgo(plant.nextWatring!, DateTime.now())}'),
                    ),
                  ))
              .toList(),

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
