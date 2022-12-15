import 'dart:html';

abstract class ImageLoaderSaver {
  Future<String> loadImage(String url);
  Future<String> saveImage(String url);
}

class ImageManager implements ImageLoaderSaver {

  /// get file base path
  Future<String> getFilePath() async {
    final String path = await window.requestFileSystem(1000000000);
    return path;
  }
  
  @override
  Future<String> loadImage(String url) {
    return Future.value(url);
  }

  @override
  Future<String> saveImage(String url) {
        File file = File(await getFilePath()); // 1

    return Future.value(url);
  }
}
