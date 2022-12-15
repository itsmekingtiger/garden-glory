import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/inputs.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class NewPlantPage extends ConsumerStatefulWidget {
  const NewPlantPage({Key? key}) : super(key: key);

  @override
  _NewPlantPageState createState() => _NewPlantPageState();
}

class _NewPlantPageState extends ConsumerState<NewPlantPage> {
  final TextEditingController _controller = TextEditingController();
  Image? profileImage;
  final ImagePicker _picker = ImagePicker();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        'Brown Brown',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // title

            // profile image
            Container(
              width: 150,
              height: 150,
              child: file == null
                  ? GestureDetector(
                      child: const Placeholder(color: Colors.green),
                      onTap: () async {
                        setState(() async {
                          file = await _picker.pickImage(source: ImageSource.camera);
                        });
                      },
                    )
                  : FutureBuilder(
                      future: file?.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.memory(snapshot.data!);
                        } else {
                          return const Placeholder(color: Colors.red);
                        }
                      },
                    ),
            ),
            VSpace.md,

            // name
            DecoInput(
              controller: _controller,
              maxWith: 200,
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        child: Container(
          height: 50,
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
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
            '/new_plant/set_watering',
            arguments: _WateringArgs(name: _controller.text),
          );
        },
      ),
    );
  }
}

@immutable
class _WateringArgs {
  final String name;

  const _WateringArgs({
    required this.name,
  });
}

class NewPlanSetWateringPage extends ConsumerStatefulWidget {
  const NewPlanSetWateringPage({Key? key}) : super(key: key);

  @override
  _NewPlanSetWateringPageState createState() => _NewPlanSetWateringPageState();
}

class _NewPlanSetWateringPageState extends ConsumerState<NewPlanSetWateringPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as _WateringArgs;

    return Scaffold(
      appBar: MyAppBar(
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
                height: 50,
                color: Theme.of(context).errorColor,
                alignment: Alignment.center,
                child: Text(
                  '설정하지 않음',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                ),
              ),
              onTap: () {
                ref.read(plantListProvider.notifier).add(name: _controller.text, wateringEvery: 0);
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 50,
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

                  ref.read(plantListProvider.notifier).add(
                        name: args.name,
                        wateringEvery: period,
                      );
                  Navigator.of(context).pop();
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

class ProfilePreview extends StatefulWidget {
  const ProfilePreview({super.key});

  @override
  State<ProfilePreview> createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(100.0),
          decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
        ),
        Container(
          margin: const EdgeInsets.all(20.0),
          decoration:
              BoxDecoration(color: Colors.orange, shape: BoxShape.circle, border: Border.all(color: Colors.white)),
        ),
      ],
    );
  }
}
