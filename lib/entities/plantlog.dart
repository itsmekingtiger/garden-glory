import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class PlantLog {
  final String id;
  final String text;
  final Set<TagType> tagType;
  final DateTime createdAt;
  final String? image;

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
    String? profileImage,
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
