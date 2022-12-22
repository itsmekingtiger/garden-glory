import 'package:brown_brown/entities/plantlog.dart';
import 'package:brown_brown/entities/tag_type.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';

part 'plant.g.dart';

@immutable
@HiveType(typeId: 0)
class Plant {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<PlantLog> logs;

  @HiveField(3)
  final int wateringEvery;

  @HiveField(4)
  final String? profileImage;

  const Plant({
    required this.id,
    required this.name,
    required this.logs,
    required this.wateringEvery,
    this.profileImage,
  });

  PlantLog? mostRecentLog() => logs.isNotEmpty ? logs.last : null;

  DateTime? get lastWatering => logs.lastWhereOrNull((log) => log.tags.contains(TagType.watering))?.createdAt;
  DateTime? get nextWatring => lastWatering?.add(Duration(days: wateringEvery));

  /// today Must have time 12:59:59
  bool needToWatering(DateTime today) {
    if (wateringEvery == 0) return false;

    return nextWatring == null ? false : nextWatring!.isBefore(today);
  }

  int get daysWithFor => logs.isEmpty ? 0 : DateTime.now().difference(logs.first.createdAt).inDays;
  String get avgWatering =>
      (daysWithFor / logs.where((log) => log.tags.contains(TagType.watering)).length).toStringAsFixed(1);
  String get avgFeeding =>
      (daysWithFor / logs.where((log) => log.tags.contains(TagType.feeding)).length).toStringAsFixed(1);

  Plant copyWith({
    String? id,
    String? name,
    List<PlantLog>? logs,
    int? wateringEvery,
    String? profileImage,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      logs: logs ?? this.logs,
      wateringEvery: wateringEvery ?? this.wateringEvery,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
