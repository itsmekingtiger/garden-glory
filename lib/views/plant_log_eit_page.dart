import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LogEditMode {
  add,
  edit,
}

class PlantLogEditPage extends ConsumerWidget {
  static const pageUrl = '/plant_log_edit';
  const PlantLogEditPage({super.key});

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
        children: [
          Text(
            '${plant.name}에게 어떤 일이 있었나요?',
            style: Theme.of(context).textTheme.headline5,
          ),

          // 날짜
          // DatePickerDialog(
          //   initialDate: DateTime.now(),
          //   firstDate: DateTime.now().subtract(Duration(days: 365)),
          //   lastDate: DateTime.now(),
          // ),

          // 타입

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

          // 사진
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  icon: Icon(CupertinoIcons.camera),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ],
      ),

      //
      bottomSheet: Expanded(
        child: GestureDetector(
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
      ),
    );
  }
}
