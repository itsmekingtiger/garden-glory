import 'package:flutter/foundation.dart' show immutable;

@immutable
class Plant {
  final String id;
  final String name;
  final List<PlantLog> logs;
  final int wateringEvery;

  const Plant({
    required this.id,
    required this.name,
    required this.logs,
    required this.wateringEvery,
  });

  bool needToWatering(DateTime today) {
    if (wateringEvery == 0) return false;

    final lastWatering = logs
        .where((log) => log.logType.contains(logTypeWatering))
        .map((log) => log.createdAt)
        .reduce((value, element) => value.isAfter(element) ? value : element);
    final nextWatering = lastWatering.add(Duration(days: wateringEvery));
    return nextWatering.isBefore(today);
  }
}

const String logTypeWatering = 'watering';
const String logTypeSeeding = 'seeding';
const String logTypeGerminated = 'germinated';
const String logTypePotChanging = 'potChanging';
const String logTypeToday = 'today';
const String logTypeNewLeaf = 'newLeaf';
const String logTypeFlower = 'flower';
const String logTypeSuffering = 'suffering';
const String logTypeFeeding = 'feeding';
const String logTypeOther = 'other';

@immutable
class PlantLog {
  final String id;
  final String title;
  final String description;
  final List<String> logType;
  final DateTime createdAt;

  const PlantLog({
    required this.id,
    required this.title,
    required this.description,
    required this.logType,
    required this.createdAt,
  });
}
