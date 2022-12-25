import 'dart:io';
import 'dart:ui';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/entities/plantlog.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/buttons.dart';
import 'package:brown_brown/ui/colors.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/views/edit_plant_page.dart';
import 'package:brown_brown/views/plant_log_edit_page.dart';
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
                return GloryTimeLineItem(plant: plant, log: log);
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
    );
    final titleStyle = textTheme.headline4!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
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
                child: Image.file(File(plant.profileImage!), fit: BoxFit.cover),
              ),
            Positioned(
              left: Insets.md,
              bottom: 28,
              child: Container(
                color: Color(0xFF808000),
                child: Text(plant.name, style: titleStyle),
              ),
            ),
            // FIXME: Plant에 CreatedAt 추가
            Positioned(
              left: Insets.md,
              bottom: Insets.md,
              child: Container(
                color: Color(0xFF808000),
                child: drawDaysWithForText(plant, subtitleStyle),
              ),
            ),
          ],
        ),
      ),
      leading: _ActionButton(
        child: Icon(CupertinoIcons.back),
        onTab: () => Navigator.of(context).pop(),
      ),
      actions: [
        _ActionButton(
          child: Icon(CupertinoIcons.pen),
          onTab: () => Navigator.of(context).pushNamed(EditPlantPage.pageUrl, arguments: {'plantId': plant.id}),
        ),
      ],
    );
  }

  Text drawDaysWithForText(Plant plant, TextStyle subtitleStyle) {
    final days = plant.daysWithFor;
    final msg = days == 0 ? '아직 기록이 없어요' : '$days일 동안 함께 했어요';

    return Text(msg, style: subtitleStyle);
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.child,
    required this.onTab,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: Center(
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: GestureDetector(
              onTap: onTab,
              child: Container(
                height: 50,
                width: 50,
                color: Colors.grey.shade200.withOpacity(0.1),
                child: Center(
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// https://stackoverflow.com/a/50665520
class GloryTimeLineItem extends StatelessWidget {
  const GloryTimeLineItem({super.key, required this.plant, required this.log});

  final Plant plant;
  final PlantLog log;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // contents
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                drawDateTitleAndEditButton(context),
                VSpace.sm,
                if (log.image != null) ...[Image(image: FileImage(File(log.image!))), VSpace.sm],
                drawTagChips(context),
                VSpace.sm,
                Text(log.text, style: Theme.of(context).textTheme.bodyMedium),
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

  Row drawTagChips(BuildContext context) {
    return Row(children: [
      ...log.tags
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  label: Text(
                    e.translateKR,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: CustomColor.tosslightblue),
                  ),
                  visualDensity: visualDensityMin,
                  backgroundColor: CustomColor.tosslightblueAccent,
                ),
              ))
          .toList(),
    ]);
  }

  Row drawDateTitleAndEditButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(log.date, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
        GloryTinyTextButton(
          onPressed: () => Navigator.of(context).pushNamed(
            PlantLogEditPage.pageUrl,
            arguments: {
              'plant': plant,
              'log': log,
            },
          ),
          text: '수정',
        ),
      ],
    );
  }
}
