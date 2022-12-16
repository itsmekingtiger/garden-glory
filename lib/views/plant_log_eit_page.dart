import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantLogEditPage extends ConsumerWidget {
  static const pageUrl = '/plant_log_edit';
  const PlantLogEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    return Scaffold(
      appBar: MyAppBar(context, 'name'),
      body: Column(
        children: [
          // profile
          // name
          // logs
          // statics
        ],
      ),
    );
  }
}
