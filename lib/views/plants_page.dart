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
              return ZoomOutAnimationWrapper(
                child: PlantListItem(
                  isPressed: false,
                  plant: plants[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ZoomOutAnimationWrapper extends StatefulWidget {
  const ZoomOutAnimationWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<ZoomOutAnimationWrapper> createState() => _ZoomOutAnimationWrapperState();
}

class _ZoomOutAnimationWrapperState extends State<ZoomOutAnimationWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
    _controller.reset();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void pressed(event) {
    _controller.forward();
    setState(() {
      isPressed = true;
    });
  }

  void canclePressed() {
    _controller.reverse();
    setState(() {
      isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _animation,
        curve: Interval(0, 1, curve: Curves.easeOut),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Listener(
          onPointerDown: pressed,
          onPointerUp: (event) => canclePressed(),
          onPointerCancel: (event) => canclePressed(),
          child: withPressedFilter(),
        ),
      ),
    );
  }

  Widget withPressedFilter() {
    return isPressed ? ColorFiltered(colorFilter: ColorFilters.darkerAlphaScale, child: widget.child) : widget.child;
  }
}

class PlantListItem extends StatelessWidget {
  const PlantListItem({
    Key? key,
    required this.isPressed,
    required this.plant,
  }) : super(key: key);

  final bool isPressed;
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final profileImage = plant.profileImage == null ? null : FileImage(File(plant.profileImage!));

    final lastLogDate =
        plant.mostRecentLog() == null ? '아직 기록이 없어요' : dateAgo(plant.mostRecentLog()!.createdAt, kEndOfToday);

    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        visualDensity: VisualDensity.compact,
        backgroundColor: MaterialStateProperty.all<Color>(isPressed ? Colors.grey[300]! : Colors.grey[200]!),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(
          '/plant_detail',
          arguments: PlantDetailPageArgs(plant.id),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: profileImage),

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
                        Text(lastLogDate, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),

                  // write log button
                  TextButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      backgroundColor:
                          MaterialStateProperty.all<Color>(isPressed ? Colors.grey[200]! : Colors.grey[300]!),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        PlantLogEditPage.pageUrl,
                        arguments: {'plant': plant},
                      );
                    },
                    child: Text('글쓰기', style: Theme.of(context).textTheme.bodySmall),
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
