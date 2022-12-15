import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/inputs.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '새로운 식물을 등록해주세요',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            // profile image
            Container(
              width: 150,
              height: 150,
              child: file == null
                  ? GestureDetector(
                      child: const Placeholder(color: Colors.green),
                      onTap: () async {
                        setState(() async {
                          file = await _picker.pickImage(
                              source: ImageSource.camera);
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
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
        ),
        onTap: () {
          ref
              .read(plantListProvider.notifier)
              .add(name: _controller.text, wateringEvery: 0);
        },
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
          decoration:
              const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
        ),
        Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white)),
        ),
      ],
    );
  }
}
