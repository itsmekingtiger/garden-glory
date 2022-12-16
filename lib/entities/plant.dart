import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class Plant {
  final String id;
  final String name;
  final List<PlantLog> logs;
  final int wateringEvery;
  final File? profileImage;

  const Plant({
    required this.id,
    required this.name,
    required this.logs,
    required this.wateringEvery,
    this.profileImage,
  });

  bool needToWatering(DateTime today) {
    if (wateringEvery == 0) return false;

    final lastWatering = logs
        .where((log) => log.logType.contains(TagType.watering))
        .map((log) => log.createdAt)
        .reduce((value, element) => value.isAfter(element) ? value : element);
    final nextWatering = lastWatering.add(Duration(days: wateringEvery));
    return nextWatering.isBefore(today);
  }
}

enum TagType {
  watering(0xFF6680B3),
  seeding(0xFF66994D),
  germinated(0xFF00E680),
  potChanging(0xFF999933),
  today(0xFF00B3E6),
  newLeaf(0xFF66E64D),
  flower(0xFFFFFF99),
  suffering(0xFF991AFF),
  feeding(0xFF999966);

  const TagType(this.color);

  final int color;
}

@immutable
class PlantLog {
  final String id;
  final String title;
  final String description;
  final Set<TagType> logType;
  final DateTime createdAt;

  const PlantLog({
    required this.id,
    required this.title,
    required this.description,
    required this.logType,
    required this.createdAt,
  });
}
