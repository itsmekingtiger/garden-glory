import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Edit pubspec.yaml to include the following lines:
///
/// flutter:
///   assets:
///     - .git/HEAD         # This file points out the current branch of the project.
///     - .git/ORIG_HEAD    # This file points to the commit id at origin (last commit id of the remote repository).
///     - .git/refs/heads/  # This directory includes files for each branch which points to the last commit id (local repo).
///
/// [출처](https://stackoverflow.com/questions/63888873/show-git-last-commit-hash-and-current-branch-tag-in-flutter-app)
Future<Map<String, String>> getBuildInfo() async {
  String commitId = '';
  String head = '';
  String branch = '';

  try {
    commitId = await rootBundle.loadString('../.git/ORIG_HEAD');
    head = await rootBundle.loadString('../.git/HEAD');
    branch = head.split('/').last;
  } catch (e) {
    // ignore silently
  }

  final pkgInfo = await PackageInfo.fromPlatform();

  return {
    'version': '${pkgInfo.version}+${pkgInfo.buildNumber}',
    'head': head,
    'commitId': commitId.substring(0, 6),
    'branch': branch,
  };
}
