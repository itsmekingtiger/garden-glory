import 'dart:io';

import 'package:brown_brown/images/image_manger.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/utils/platform_util.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<dynamic> showGloryImagePicker(BuildContext context, void Function(File? file) onPicked) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => GloryImagePicker(onPicked: onPicked),
  );
}

class GloryImagePicker extends StatefulWidget {
  const GloryImagePicker({super.key, required this.onPicked});

  final void Function(File? file) onPicked;

  @override
  State<GloryImagePicker> createState() => _GloryImagePickerState();
}

class _GloryImagePickerState extends State<GloryImagePicker> {
  Image? profileImage;
  final ImagePicker _picker = ImagePicker();

  VoidCallback _pickWith(source) {
    return () async {
      XFile? f = await pickByPlatform(source);
      if (f == null) {
        return;
      }

      final savedImage = await imageManager.save(File(f.path));

      widget.onPicked(savedImage);
    };
  }

  Future<XFile?> pickByPlatform(source) async {
    if (isMobile()) {
      return await _picker.pickImage(source: source);
    }

    if (isDesktop()) {
      final typeGroup = XTypeGroup(
        label: 'images',
        extensions: const ['jpg', 'png', 'heic'],
      );

      return await openFile(acceptedTypeGroups: [typeGroup]);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BottomSheet(
        shape: RoundedRectangleBorder(borderRadius: Corners.lgBorder),
        onClosing: () {},
        builder: (context) {
          // Pick image from gallery/camera
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Corners.lgRadius)),
                  leading: Icon(Icons.camera_alt),
                  title: Text('카메라'),
                  onTap: () async {
                    Navigator.pop(context);
                    _pickWith(ImageSource.camera)();
                  }),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Corners.lgRadius)),
                leading: Icon(Icons.image),
                title: Text('갤러리'),
                onTap: () async {
                  Navigator.pop(context);
                  _pickWith(ImageSource.gallery)();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
