import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'brown brwon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline3: TextStyle(fontSize: 20),
        ),
      ),
      home: const NewPlantPage(title: 'New plant'),
    );
  }
}

class NewPlantPage extends StatefulWidget {
  const NewPlantPage({super.key, required this.title});

  final String title;

  @override
  State<NewPlantPage> createState() => _NewPlantPageState();
}

class _NewPlantPageState extends State<NewPlantPage> {
  Image? profileImage;
  final ImagePicker _picker = ImagePicker();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.tree), label: '내 식물'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar), label: '캘린더'),
      ]),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add a new plant',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            file == null
                ? Placeholder(
                    color: Colors.green,
                  )
                : FutureBuilder(
                    future: file?.readAsBytes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.memory(snapshot.data!);
                      } else {
                        return Placeholder(
                          color: Colors.red,
                        );
                      }
                    },
                  ),
            ElevatedButton(
              onPressed: () async {
                setState(() async {
                  if (kIsWeb) {
                    var pic = await _picker.pickImage(source: ImageSource.camera);
                  } else {
                    file = await _picker.pickImage(source: ImageSource.camera);
                  }
                });
              },
              child: const Text('Select profile image'),
            ),
            TextField(),
          ],
        ),
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
    return Container();
  }
}
