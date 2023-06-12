import 'package:brown_brown/views/wiki/fertilizer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MiniWikiPage extends ConsumerWidget {
  static const pageUrl = '/mini-wiki';

  MiniWikiPage({super.key});

  static const rawdata = {
    '하이포넥스 하이그레이드 개화촉진': {
      'npk': [
        0,
        6,
        4,
      ],
    },
    '하이포넥스 하이그레이드': {
      'npk': [
        7,
        10,
        6,
      ],
    },
    '하이포넥스 레이쇼': {
      'npk': [
        6,
        10,
        5,
      ],
    },
    '다이나 그로 폴리지 프로': {
      'npk': [
        9,
        3,
        6,
      ],
    },
    '다이나 그로 블룸': {
      'npk': [
        3,
        12,
        6,
      ],
    },
    '다이나 그로 그로우': {
      'npk': [
        7,
        9,
        5,
      ],
    },
  };

  final fetrilizerDataset = rawdata.entries
      .map((e) => FertilizerData(
            e.key,
            e.value['npk']![0],
            e.value['npk']![1],
            e.value['npk']![2],
          ))
      .sorted((a, b) => a.pctOfP() - b.pctOfP())
      .sorted((a, b) => a.pctOfN() - b.pctOfN());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Text('비료 비율'),
          ...fetrilizerDataset.map((e) => FertilizerCard(e)),
        ],
      ),
    );
  }
}
