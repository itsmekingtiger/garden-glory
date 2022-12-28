import 'dart:io';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/images/image_manger.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/glory_image_picker.dart';
import 'package:brown_brown/ui/inputs.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditPlantPage extends ConsumerStatefulWidget {
  static const pageUrl = '/edit_plant_page';

  final String plantId;

  const EditPlantPage({Key? key, required this.plantId}) : super(key: key);

  @override
  _EditPlantPageState createState() => _EditPlantPageState();
}

class _EditPlantPageState extends ConsumerState<EditPlantPage> {
  late TextEditingController nameCtrl;
  late TextEditingController wateringCtrl;
  File? file;

  late Plant plant;

  @override
  void initState() {
    super.initState();
    plant = ref.read(plantListProvider).firstWhere((p) => p.id == widget.plantId);

    nameCtrl = TextEditingController(text: plant.name);
    wateringCtrl = TextEditingController(text: plant.wateringEvery.toString());
    if (plant.profileImage != null) file = File(plant.profileImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SubPageAppBar(context, 'Brown Brown', actions: [
          IconButton(
              onPressed: () {
                // FIXME: PlantDetailPage에서 plant가 없기 때문에 에러 발생.
                // 프로덕션 빌드에서는 큰 문제가 없지만 디버깅에서는 브레이크가 걸림.
                // 이 페이지는 MainPage와 PlantsPage에서 접근 가능하기 때문에 popuntil도 사용하기 곤란.
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ref.watch(plantListProvider.notifier).removePlant(plant);
              },
              icon: Icon(CupertinoIcons.trash))
        ]),
        body: Column(
          children: <Widget>[
            VSpace.xl,

            // profile image
            GestureDetector(
              onTap: () async {
                showGloryImagePicker(
                  context,
                  (file) => setState(() => this.file = file),
                );
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(
                      maxRadius: 150,
                      backgroundImage: file == null ? null : resolveImageProvider(file!.path),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            VSpace.xl,

            // name
            DecoInput(
              controller: nameCtrl,
              maxWith: 200,
            ),
            VSpace.lg,

            // 물주기
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              DecoInput(
                controller: wateringCtrl,
                maxWith: 40,
                keyboardType: TextInputType.number,
                maxLength: 2,
                textAlign: TextAlign.center,
              ),
              Text('일에 한번씩 물주기'),
            ]),
          ],
        ),
        bottomSheet: BottomSheetButton(
          child: Text('수정', style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white)),
          onTap: () => tryCreate(context),
        ),
      ),
    );
  }

  Future<void> tryCreate(BuildContext context) async {
    if (nameCtrl.text.trim().isEmpty) {
      return alert('식물 이름이 비어있습니다.');
    }

    if (int.tryParse(wateringCtrl.text) == null) {
      return alert('물주기에 올바른 숫자를 입력하세요.');
    }

    ref.watch(plantListProvider.notifier).editPlant(
          id: widget.plantId,
          name: nameCtrl.text,
          wateringEvery: int.parse(wateringCtrl.text),
          profileImage: file?.path,
        );

    Navigator.of(context).pop();
  }

  Future<void> alert(String msg2) async {
    Fluttertoast.showToast(
      msg: msg2,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
