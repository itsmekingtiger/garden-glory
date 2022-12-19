import 'dart:io';

import 'package:brown_brown/images/image_manger.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/glory_image_picker.dart';
import 'package:brown_brown/ui/inputs.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class NewPlantPage extends ConsumerStatefulWidget {
  static const pageUrl = '/new_plant';

  const NewPlantPage({Key? key}) : super(key: key);

  @override
  _NewPlantPageState createState() => _NewPlantPageState();
}

class _NewPlantPageState extends ConsumerState<NewPlantPage> {
  final TextEditingController _controller = TextEditingController();
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        context,
        'Brown Brown',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // title

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
            VSpace.md,

            // name
            DecoInput(
              controller: _controller,
              maxWith: 200,
              hintText: '식물 이름',
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        child: Container(
          height: 50 + MediaQuery.of(context).viewPadding.bottom,
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(Insets.lg),
          child: Text(
            '다음',
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
          ),
        ),
        onTap: () {
          if (_controller.text.isEmpty) {
            Fluttertoast.showToast(
              msg: '식물 이름이 비어있습니다.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return;
          }
          Navigator.of(context).popAndPushNamed(
            NewPlanSetWateringPage.pageUrl,
            arguments: _WateringArgs(name: _controller.text, image_path: file?.path),
          );
        },
      ),
    );
  }
}

@immutable
class _WateringArgs {
  final String name;
  final String? image_path;

  const _WateringArgs({
    required this.name,
    this.image_path,
  });
}

class NewPlanSetWateringPage extends ConsumerStatefulWidget {
  static const pageUrl = '/new_plant/set_watering';

  const NewPlanSetWateringPage({Key? key}) : super(key: key);

  @override
  _NewPlanSetWateringPageState createState() => _NewPlanSetWateringPageState();
}

class _NewPlanSetWateringPageState extends ConsumerState<NewPlanSetWateringPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as _WateringArgs;

    Future<void> createNewPlant(int period) async {
      File? profileImage;

      if (args.image_path != null && args.image_path!.isNotEmpty) {
        profileImage = await imageManager.save(File(args.image_path!));
      }

      ref.read(plantListProvider.notifier).add(
            name: args.name,
            wateringEvery: period,
            profileImage: profileImage,
          );

      // FIXME: Is it safe approach?
      // [flutter - Do not use BuildContexts across async gaps - Stack Overflow](https://stackoverflow.com/questions/68871880)
      if (!mounted) return;
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: SubPageAppBar(
        context,
        'Brown Brown',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // title
            Text(
              '물주기를 설정할까요?',
              style: Theme.of(context).textTheme.headline5,
            ),

            Lottie.asset('assets/lottie/72315-watering-plants.json', height: 200),

            VSpace.md,

            // name
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              DecoInput(
                controller: _controller,
                maxWith: 40,
                keyboardType: TextInputType.number,
                maxLength: 2,
                textAlign: TextAlign.center,
              ),
              Text('일에 한번씩 물주기'),
            ]),
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 50 + MediaQuery.of(context).viewPadding.bottom,
                color: Theme.of(context).errorColor,
                alignment: Alignment.center,
                child: Text(
                  '설정하지 않음',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                ),
              ),
              onTap: () {
                createNewPlant(0);
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 50 + MediaQuery.of(context).viewPadding.bottom,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.center,
                child: Text(
                  '다음',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                ),
              ),
              onTap: () {
                try {
                  final period = int.parse(_controller.text);

                  createNewPlant(period);
                } catch (e) {
                  _controller.clear();
                  Fluttertoast.showToast(
                    msg: 'Wrong input. Must be number',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
