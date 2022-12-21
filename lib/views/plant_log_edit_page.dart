import 'dart:io';

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
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantLogEditPage extends ConsumerStatefulWidget {
  static const pageUrl = '/plant_log_edit';

  final Plant plant;
  final PlantLog? log;

  const PlantLogEditPage({super.key, required this.plant, this.log});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlantLogEditPageState();
}

class _PlantLogEditPageState extends ConsumerState<PlantLogEditPage> {
  final DateTime now = DateTime.now();
  late final DateTime firstDate = now.subtract(Duration(days: 365));

  String id = '';
  late TextEditingController txtCtrl;
  DateTime dateTime = DateTime.now();
  Set<TagType> tags = <TagType>{};
  File? file;

  @override
  void initState() {
    super.initState();

    if (widget.log != null) {
      id = widget.log!.id;
      txtCtrl = TextEditingController(text: widget.log!.text);
      dateTime = widget.log!.createdAt;
      tags = widget.log!.tagType;
      file = widget.log!.image;
    } else {
      txtCtrl = TextEditingController(text: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        context,
        '오늘의 기록',
        actions: widget.log == null
            ? null
            : [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      ref.watch(plantListProvider.notifier).removeLog(
                            plant: widget.plant,
                            log: widget.log!,
                          );
                    },
                    icon: Icon(CupertinoIcons.trash))
              ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VSpace.md,

          // 날짜
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: CircleAvatar(
              backgroundImage: widget.plant.profileImage == null ? null : FileImage(widget.plant.profileImage!),
            ),
            title: Text(widget.plant.name),
            subtitle: Row(
              children: [
                Text(
                  formatDateTime(dateTime),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                HSpace.sm,
                if (isNotSameDate(dateTime, DateTime.now()))
                  GloryTinyTextButton(
                    onPressed: () => setState(() => dateTime = DateTime.now()),
                    text: 'Set to today',
                  )
              ],
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: dateTime,
                firstDate: firstDate,
                lastDate: now,
              );

              if (date != null) {
                setState(() => dateTime = date);
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
              controller: txtCtrl,
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
                            /// Note:
                            /// 안에서는 setState를 해도 showModalBottomSheet로 그린 위젯은 rerender 되지 않음.
                            /// 이를 해결하기 위해서는 StatefulBuilder로 inner Widget을 감싸야함.
                            /// 또한 setState를 StatefulBuilder.builder 콜백의 인자로 주어지는 또다른 setState로 감싸야함.
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => StatefulBuilder(
                                builder: (context, setOutterState) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: TagBottomSheet(
                                      tags: tags,
                                      toggle: (tag) {
                                        tags.contains(tag)
                                            ? setOutterState(() => setState(() {
                                                  tags.remove(tag);
                                                  tags = {...tags};
                                                }))
                                            : setOutterState(() => setState(() {
                                                  tags = {...tags, tag};
                                                }));
                                      }),
                                ),
                              ),
                            );
                          },
                        ),
                        ...tags.map((tag) {
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
          if (widget.log == null) {
            ref.watch(plantListProvider.notifier).addLog(
                  plantId: widget.plant.id,
                  description: txtCtrl.text,
                  tagType: tags,
                  createdAt: dateTime,
                  image: file == null ? null : File(file!.path),
                );
          } else {
            ref.watch(plantListProvider.notifier).editLog(
                  plant: widget.plant,
                  log: widget.log!,
                  description: txtCtrl.text,
                  tagType: tags,
                  createdAt: dateTime,
                  image: file == null ? null : File(file!.path),
                );
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class TagBottomSheet extends StatelessWidget {
  const TagBottomSheet({
    Key? key,
    required this.tags,
    required this.toggle,
  }) : super(key: key);

  final Set<TagType> tags;
  final void Function(TagType tag) toggle;

  List<TagBottomSheetItem> drawItems(BuildContext context) {
    return TagType.values.map((e) {
      final checked = tags.contains(e);

      return TagBottomSheetItem(
        e.translateKR,
        trailing: checked ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
        onTap: () => toggle(e),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: RoundedRectangleBorder(borderRadius: Corners.iPhoneBorder),
      onClosing: () {},
      builder: (context) {
        return ListView(
          children: drawItems(context),
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
