import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantsDetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    Widget drawWateringNotifications(List<Plant> plants) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return Container(
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
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text('오늘의 물주기', style: Theme.of(context).textTheme.bodyText2),
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
          );
        },
      );
    }

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
