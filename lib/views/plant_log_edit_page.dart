import 'dart:math';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

enum LogEditMode {
  add,
  edit,
}

List<Color> colorArray = [
  Color(0xFF00B3E6),
  Color(0xFF00E680),
  Color(0xFF1AB399),
  Color(0xFF1AFF33),
  Color(0xFF3366E6),
  Color(0xFF33991A),
  Color(0xFF33FFCC),
  Color(0xFF4D8000),
  Color(0xFF4D8066),
  Color(0xFF4D80CC),
  Color(0xFF4DB380),
  Color(0xFF4DB3FF),
  Color(0xFF66664D),
  Color(0xFF6666FF),
  Color(0xFF6680B3),
  Color(0xFF66991A),
  Color(0xFF66994D),
  Color(0xFF66E64D),
  Color(0xFF809900),
  Color(0xFF809980),
  Color(0xFF80B300),
  Color(0xFF9900B3),
  Color(0xFF991AFF),
  Color(0xFF999933),
  Color(0xFF999966),
  Color(0xFF99E6E6),
  Color(0xFF99FF99),
  Color(0xFFB33300),
  Color(0xFFB34D4D),
  Color(0xFFB366CC),
  Color(0xFFB3B31A),
  Color(0xFFCC80CC),
  Color(0xFFCC9999),
  Color(0xFFCCCC00),
  Color(0xFFCCFF1A),
  Color(0xFFE6331A),
  Color(0xFFE64D66),
  Color(0xFFE666B3),
  Color(0xFFE666FF),
  Color(0xFFE6B333),
  Color(0xFFE6B3B3),
  Color(0xFFE6FF80),
  Color(0xFFFF1A66),
  Color(0xFFFF3380),
  Color(0xFFFF33FF),
  Color(0xFFFF4D4D),
  Color(0xFFFF6633),
  Color(0xFFFF99E6),
  Color(0xFFFFB399),
  Color(0xFFFFFF99),
];

/// [Determine If A Color Is Bright Or Dark Using JavaScript - Andreas Wik](https://awik.io/determine-color-bright-dark-using-javascript/)
bool isLightColor(int r, int g, int b) {
  // HSP (Highly Sensitive Poo) equation from http://alienryderflex.com/hsp.html
  final hsp = sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b));

  // Using the HSP value, determine whether the color is light or dark
  return hsp > 127.5;
}

List<int> toRGB(int color) {
  return [
    (color >> 16) & 0xFF, // red
    (color >> 8) & 0xFF, // green
    color & 0xFF, // blue
  ];
}

class _DateTimeNotifier extends StateNotifier<DateTime> {
  _DateTimeNotifier() : super(DateTime.now());

  void setDate(DateTime date) {
    state = date;
  }
}

final _dateTimeProvider = StateNotifierProvider<_DateTimeNotifier, DateTime>((ref) => _DateTimeNotifier());

class _TagNotifier extends StateNotifier<Set<TagType>> {
  _TagNotifier() : super(<TagType>{});

  void on(TagType tagType) => state = {...state, tagType};

  void off(TagType tagType) => state = {...state..remove(tagType)};
}

final _tagProvider = StateNotifierProvider<_TagNotifier, Set<TagType>>((ref) => _TagNotifier());

class PlantLogEditPage extends ConsumerWidget {
  static const pageUrl = '/plant_log_edit';
  PlantLogEditPage({super.key});

  final DateTime now = DateTime.now();
  late final DateTime firstDate = now.subtract(Duration(days: 365));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final plant = args['plant'] as Plant;

    Future<void> onSubmitted() async {
      final editMode = args['mode'] as LogEditMode;

      if (editMode == LogEditMode.add) {
        // add
      } else {
        // edit
      }
    }

    final List<Plant> plants = ref.watch(plantListProvider);

    return Scaffold(
      appBar: SubPageAppBar(context, '오늘의 기록'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VSpace.md,
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: CircleAvatar(
              backgroundImage: plant.profileImage == null ? null : FileImage(plant.profileImage!),
            ),
            title: Text(plant.name),
            subtitle: Text(
              DateFormat('yyyy-MM-dd').format(ref.watch(_dateTimeProvider)),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: ref.watch(_dateTimeProvider),
                firstDate: firstDate,
                lastDate: now,
              );

              if (date != null) {
                ref.watch(_dateTimeProvider.notifier).setDate(date);
              }
            },
          ),

          // 내용
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '내용',
                alignLabelWithHint: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
              minLines: 5,
              maxLines: 20,
            ),
          ),

          // 태그, 사진
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        TextButton(
                          child: Text('태그 편집'),
                          onPressed: () async {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(20),
                                child: TagBottomSheet(),
                              ),
                            );
                          },
                        ),
                        ...ref.watch(_tagProvider).map((tag) {
                          final colorRaw = tag.color;
                          final color = Color(colorRaw);
                          final rgb = toRGB(colorRaw);
                          final isLight = isLightColor(rgb[0], rgb[1], rgb[2]);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Chip(
                              visualDensity: VisualDensity.compact,
                              key: ValueKey(tag),
                              label: Text(tag.translateKR,
                                  style: TextStyle(color: isLight ? Colors.grey[800] : Colors.white)),
                              deleteIconColor: isLight ? Colors.grey[800] : Colors.white,
                              backgroundColor: color,
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  IconButton(
                    constraints: BoxConstraints.tightFor(width: 40, height: 40),
                    icon: Icon(CupertinoIcons.camera),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      //
      bottomSheet: GestureDetector(
        child: Container(
          height: 50,
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          child: Text(
            '작성',
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
          ),
        ),
        onTap: () {
          // TODO:
        },
      ),
    );
  }
}

class TagBottomSheet extends ConsumerWidget {
  const TagBottomSheet({
    Key? key,
  }) : super(key: key);

  List<TagBottomSheetItem> drawItems(BuildContext context, WidgetRef ref) {
    return TagType.values.map((e) {
      final checked = ref.watch(_tagProvider).contains(e);

      return TagBottomSheetItem(
        e.translateKR,
        trailing: checked ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
        onTap: () => checked ? ref.read(_tagProvider.notifier).off(e) : ref.watch(_tagProvider.notifier).on(e),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomSheet(
      shape: RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      onClosing: () {},
      builder: (context) {
        return ListView(
          children: drawItems(context, ref),
        );
      },
    );
  }
}

class TagBottomSheetItem extends StatelessWidget {
  const TagBottomSheetItem(
    this.title, {
    Key? key,
    this.shape,
    this.leading,
    this.trailing,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  final ShapeBorder? shape;
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final Widget? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      shape: shape,
      leading: leading,
      trailing: trailing,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}
