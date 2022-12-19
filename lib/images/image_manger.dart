import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as libpath;
import 'package:path_provider/path_provider.dart';

abstract class ImageLoaderSaver {
  /// load image from disk, path could be generated value of hash or uuid
  Future<File> load(String path);
  Future<File> save(File file);
  void delete(String path);
}

class ImageManager implements ImageLoaderSaver {
  static const String _imageDir = 'images';

  ImageManager._();

  @override
  Future<File> load(String fileName) async {
    return File(await _getFullPath(_imageDir, fileName));
  }

  @override
  Future<File> save(File original) async {
    final content = await original.readAsBytes();
    final fileName = md5.convert(content).toString();
    final fullPath = await _getFullPath(_imageDir, fileName);

    final file = File(fullPath);
    if (await file.exists()) {
      return file;
    }

    await file.create(recursive: true);

    return original.copy(fullPath);
  }

  @override
  void delete(String path) {
    throw UnimplementedError();
  }

  Future<String> _getFullPath(
      [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7, String? part8]) async {
    final directory = await getApplicationDocumentsDirectory();

    return libpath.join(directory.path, part2, part3, part4, part5, part6, part7, part8);
  }
}

ImageManager imageManager = ImageManager._();

ImageProvider resolveImageProvider(String pathOrUrl) {
  if (kIsWeb) {
    return NetworkImage(pathOrUrl);
  } else {
    return FileImage(File(pathOrUrl));
  }
}
