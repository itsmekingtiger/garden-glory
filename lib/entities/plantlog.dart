import 'package:brown_brown/entities/tag_type.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:hive_flutter/hive_flutter.dart';

part 'plantlog.g.dart';

@immutable
@HiveType(typeId: 1)
class PlantLog {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final Set<TagType> tags;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final String? image;

  const PlantLog({
    required this.id,
    required this.text,
    required this.tags,
    required this.createdAt,
    required this.image,
  });

  String get date => formatDateTimeDow(createdAt);

  PlantLog copyWith({
    String? id,
    String? text,
    Set<TagType>? tags,
    DateTime? createdAt,
    String? profileImage,
  }) {
    return PlantLog(
      id: id ?? this.id,
      text: text ?? this.text,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      image: profileImage ?? this.image,
    );
  }
}
