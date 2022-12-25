import 'dart:io';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/entities/tag_type.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/colors.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:brown_brown/views/plant_log_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends ConsumerWidget {
  static const pageUrl = '/main';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> needWaterings = ref.watch(needToWateringProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Watering Notification Section

          if (needWaterings.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('물주기를 기다리고 있어요', style: Theme.of(context).textTheme.bodySmall),
            ),

          ...needWaterings.map((plant) => drawWateringNotificationItem(plant, ref)).toList(),

          // Long time no see section
        ],
      ),
    );
  }

  Slidable drawWateringNotificationItem(Plant plant, WidgetRef ref) {
    return Slidable(
      endActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          // An action can be bigger than the others.
          flex: 1,
          onPressed: (context) => Navigator.of(context).pushNamed(
            PlantLogEditPage.pageUrl,
            arguments: {'plant': plant},
          ),
          backgroundColor: Color(0xFF386641),
          foregroundColor: Colors.white,
          icon: Icons.edit_calendar_rounded,
        ),
        SlidableAction(
          flex: 1,
          onPressed: (context) {
            ref.watch(plantListProvider.notifier).addLog(
                  plantId: plant.id,
                  description: '물을 줬어요',
                  tags: {TagType.watering},
                  createdAt: DateTime.now(),
                );
          },
          backgroundColor: Color(0xFF6a994e),
          foregroundColor: Colors.white,
          icon: Icons.water_drop,
        ),
      ]),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: plant.profileImage == null ? null : FileImage(File(plant.profileImage!)),
        ),
        title: Text(plant.name, style: GoogleFonts.notoSans(textStyle: TextStyle(fontWeight: FontWeight.w500))),
        trailing: Text(
          dateAgo(plant.nextWatring!, DateTime.now()),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColor.tosslightblue,
          ),
        ),
      ),
    );
  }
}
