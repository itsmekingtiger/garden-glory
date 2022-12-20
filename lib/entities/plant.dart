import 'dart:ffi';
import 'dart:io';

import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:collection/collection.dart';
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

  PlantLog? mostRecentLog() => logs.isNotEmpty ? logs.last : null;

  DateTime? get lastWatering => logs.lastWhereOrNull((log) => log.tagType.contains(TagType.watering))?.createdAt;
  DateTime? get nextWatring => lastWatering?.add(Duration(days: wateringEvery));

  /// today Must have time 12:59:59
  bool needToWatering(DateTime today) {
    if (wateringEvery == 0) return false;

    return nextWatring == null ? false : nextWatring!.isBefore(today);
  }

  int get daysWithFor => logs.isEmpty ? 0 : DateTime.now().difference(logs.first.createdAt).inDays;
  String get avgWatering =>
      (daysWithFor / logs.where((log) => log.tagType.contains(TagType.watering)).length).toStringAsFixed(1);
  String get avgFeeding =>
      (daysWithFor / logs.where((log) => log.tagType.contains(TagType.feeding)).length).toStringAsFixed(1);

  Plant copyWith({
    String? id,
    String? name,
    List<PlantLog>? logs,
    int? wateringEvery,
    File? profileImage,
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

enum TagType {
  today(0xFF00B3E6, '오늘'), // 🌞
  watering(0xFF4361ee, '물'), // 💦
  feeding(0xFFcb997e, '비료'), // 🍔
  potChanging(0xFFF4C095, '분갈이'), // 🪴
  newLeaf(0xFF6a994e, '신엽'), // 🍃
  flower(0xFFFFFF99, '개화'), // 🌹
  suffering(0xFF991AFF, '병충해'), //🐛
  pesticide(0xFFED2F36, '농약'), // ☣️
  germinated(0xFF00E680, '발아'), // 🌱
  seeding(0xFF582f0e, '파종'); // 🚜

  const TagType(this.color, this.translateKR);

  final int color;
  final String translateKR;
}

@immutable
class PlantLog {
  final String id;
  final String text;
  final Set<TagType> tagType;
  final DateTime createdAt;
  final File? image;

  const PlantLog({
    required this.id,
    required this.text,
    required this.tagType,
    required this.createdAt,
    required this.image,
  });

  String get date => formatDateTimeDow(createdAt);

  PlantLog copyWith({
    String? id,
    String? text,
    Set<TagType>? tagType,
    DateTime? createdAt,
    File? profileImage,
  }) {
    return PlantLog(
      id: id ?? this.id,
      text: text ?? this.text,
      tagType: tagType ?? this.tagType,
      createdAt: createdAt ?? this.createdAt,
      image: profileImage ?? this.image,
    );
  }
}
