import 'dart:io';
import 'dart:math';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/buttons.dart';
import 'package:brown_brown/ui/colors.dart';
import 'package:brown_brown/ui/glory_image_picker.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LogEditMode {
  add,
  edit,
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

class PlantLogEditPage extends ConsumerStatefulWidget {
  static const pageUrl = '/plant_log_edit';
  const PlantLogEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlantLogEditPageState();
}

class _PlantLogEditPageState extends ConsumerState {
  final DateTime now = DateTime.now();
  late final DateTime firstDate = now.subtract(Duration(days: 365));

  File? file;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final plant = args['plant'] as Plant;
    final TextEditingController ctrl = TextEditingController();

    Future<void> onSubmitted() async {
      final editMode = args['mode'] as LogEditMode;

      if (editMode == LogEditMode.add) {
        // add
      } else {
        // edit
      }
    }

    return Scaffold(
      appBar: SubPageAppBar(context, '오늘의 기록'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VSpace.md,

          // 날짜
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: CircleAvatar(
              backgroundImage: plant.profileImage == null ? null : FileImage(plant.profileImage!),
            ),
            title: Text(plant.name),
            subtitle: Row(
              children: [
                Text(
                  formatDateTime(ref.watch(_dateTimeProvider)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                HSpace.sm,
                if (isNotSameDate(ref.watch(_dateTimeProvider), DateTime.now()))
                  GloryTinyTextButton(
                    onPressed: () => ref.watch(_dateTimeProvider.notifier).setDate(DateTime.now()),
                    text: 'Set to today',
                  )
              ],
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
              controller: ctrl,
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
                    onPressed: () async {
                      showGloryImagePicker(
                        context,
                        (file) => setState(() => this.file = file),
                      );
                    },
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
          height: 50 + MediaQuery.of(context).viewPadding.bottom,
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          child: Text(
            '작성',
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
          ),
        ),
        onTap: () {
          ref.watch(plantListProvider.notifier).addLog(
                plantId: plant.id,
                description: ctrl.text,
                tagType: ref.watch(_tagProvider),
                createdAt: ref.watch(_dateTimeProvider),
                image: file == null ? null : File(file!.path),
              );
          Navigator.of(context).pop();
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
      shape: RoundedRectangleBorder(borderRadius: Corners.iPhoneBorder),
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
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
      shape: shape,
      leading: leading,
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: trailing,
      ),
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}
