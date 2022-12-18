import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantDetailPageArgs {
  final String id;
  const PlantDetailPageArgs(this.id);
}

class PlantDetailPage extends ConsumerWidget {
  static const pageUrl = '/plant_detail';
  const PlantDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as PlantDetailPageArgs;

    final Plant plant = ref.watch(plantListProvider).firstWhere((element) => element.id == args.id);

    return Scaffold(
      appBar: SubPageAppBar(context, 'name'),
      body: Column(
        children: [
          Row(
            children: [
              // plant image
              // plant name
              // plant nickname
            ],
          ),

          Text(plant.name),
          Text(plant.wateringEvery.toString()),
          // profile
          // name
          // logs

          ...plant.logs
              .take(5)
              .map((log) => ListTile(
                    title: Text(log.text, style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text(log.date),
                  ))
              .toList(),

          /// TODO: statics
          /// avg Watering (total/recent 4 month)
          /// avg Feeding (total/recent 4 month)
          /// avg New Leaves (total/recent 4 month)
        ],
      ),
    );
  }
}
