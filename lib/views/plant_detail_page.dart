import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:flutter/cupertino.dart';
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
      body: CustomScrollView(
        slivers: [
          // prifle image, name, go back, edit buttom
          drawAppBar(plant, context),

          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: plant.logs.length,
            (context, index) {
              final log = plant.logs[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: log.image == null ? null : FileImage(log.image!),
                ),
                title: Text(log.text, style: Theme.of(context).textTheme.bodyMedium),
                subtitle: Text('${log.date}, ${log.tagType.map((e) => e.translateKR)}'),
              );
            },
          )),

          /// TODO: statics
          /// avg Watering (total/recent 4 month)
          /// avg Feeding (total/recent 4 month)
          /// avg New Leaves (total/recent 4 month)
        ],
      ),
    );
  }

  SliverAppBar drawAppBar(Plant plant, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitleStyle = textTheme.bodyMedium!.copyWith(color: Colors.white);
    final titleStyle = textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.bold);

    return SliverAppBar(
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        // background: plant.profileImage == null ? null : Image.file(plant.profileImage!, fit: BoxFit.cover),
        background: Stack(
          children: [
            if (plant.profileImage != null) Image.file(plant.profileImage!, fit: BoxFit.cover),
            Positioned(
              left: Insets.md,
              bottom: 30,
              child: Text(plant.name, style: titleStyle),
            ),
            // FIXME: Plant에 CreatedAt 추가
            Positioned(
              left: Insets.md,
              bottom: Insets.md,
              child: Text('${plant.wateringEvery.toString()}일 동안 함게 했어요', style: subtitleStyle),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(color: Colors.red),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.option),
          onPressed: () => {}, // TODO: edit menu
        ),
      ],
    );
  }
}
