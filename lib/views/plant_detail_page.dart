import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/buttons.dart';
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
                final log = plant.logs.reversed.toList()[index];
                return GloryTimeLineItem(log: log);
              },
            ),
          ),

          /// TODO: statics
          /// avg Watering (total/recent 4 month)
          /// avg Feeding (total/recent 4 month)
          /// avg New Leaves (total/recent 4 month)
        ],
      ),
    );
  }

  Widget drawAppBar(Plant plant, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitleStyle = textTheme.bodyMedium!.copyWith(
      color: Colors.white,
      backgroundColor: Color(0xFF808000),
    );
    final titleStyle = textTheme.headline4!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      backgroundColor: Color(0xFF808000),
    );

    return SliverAppBar(
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        // background: plant.profileImage == null ? null : Image.file(plant.profileImage!, fit: BoxFit.cover),
        background: Stack(
          children: [
            /// SliverAppBar는 SafeArea로 쌓여있지 않기 떄문에
            /// 실제 크기 = expandedHeight + 앱바 크기이다.
            /// 따라서 expandedHeight를 기준으로 이미지를 그리고 추가적으로 여유를 둔다.
            ///
            /// 아니면 SliverPersistentHeader + SliverPersistentHeaderDelegate를 사용 할 수도 있을듯
            /// [flutter - Add SafeArea into SliverAppBar - Stack Overflow](https://stackoverflow.com/questions/62446686/add-safearea-into-sliverappbar)
            if (plant.profileImage != null)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 280,
                child: Image.file(plant.profileImage!, fit: BoxFit.cover),
              ),
            Positioned(
              left: Insets.md,
              bottom: 28,
              child: Text(plant.name, style: titleStyle),
            ),
            // FIXME: Plant에 CreatedAt 추가
            Positioned(
              left: Insets.md,
              bottom: Insets.md,
              child: drawDaysWithForText(plant, subtitleStyle),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.option),
          onPressed: () => {}, // TODO: edit menu
        ),
      ],
    );
  }

  Text drawDaysWithForText(Plant plant, TextStyle subtitleStyle) {
    final msg = plant.logs.isEmpty
        ? '아직 기록이 없어요'
        : '${DateTime.now().difference(plant.logs.first.createdAt).inDays}일 동안 함께 했어요';

    return Text(msg, style: subtitleStyle);
  }
}

///
/// https://stackoverflow.com/a/50665520
class GloryTimeLineItem extends StatelessWidget {
  const GloryTimeLineItem({super.key, required this.log});

  final PlantLog log;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(log.date, style: Theme.of(context).textTheme.headline6),
                    GloryTinyTextButton(onPressed: () {}, text: 'Edit'),
                  ],
                ),
                VSpace.sm,
                if (log.image != null) ...[Image(image: FileImage(log.image!)), VSpace.sm],
                Row(children: [
                  ...log.tagType
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              label: Text(e.translateKR),
                              visualDensity: VisualDensity.compact,
                            ),
                          ))
                      .toList(),
                ]),
                VSpace.sm,
                Text(log.text),
              ],
            ),
          ),
        ),

        // Line
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 20,
          child: Container(height: double.infinity, width: 1.0, color: Colors.grey),
        ),

        // Dot
        Positioned(
          top: 26,
          left: 16.5,
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
          ),
        )
      ],
    );
  }
}
