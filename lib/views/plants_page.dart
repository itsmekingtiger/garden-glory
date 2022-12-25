import 'dart:io';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:brown_brown/views/plant_detail_page.dart';
import 'package:brown_brown/views/plant_log_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantsPage extends ConsumerWidget {
  static const pageUrl = '/plants';

  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    return Column(
      children: [
        // List of plants
        Expanded(
          child: ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) {
              return _PlantListItem(plant: plants[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _PlantListItem extends StatelessWidget {
  const _PlantListItem({
    Key? key,
    required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/plant_detail', arguments: PlantDetailPageArgs(plant.id)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: plant.profileImage == null ? null : FileImage(File(plant.profileImage!)),
                    ),
                    // name, species, last event
                    HSpace.md,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.name,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          VSpace.xs,
                          Text(
                            plant.mostRecentLog() == null
                                ? '아직 기록이 없어요'
                                : dateAgo(plant.mostRecentLog()!.createdAt, kEndOfToday),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          PlantLogEditPage.pageUrl,
                          arguments: {'plant': plant},
                        );
                        // write log
                      },
                      child: Text('글쓰기', style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
