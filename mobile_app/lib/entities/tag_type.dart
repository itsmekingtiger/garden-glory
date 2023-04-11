import 'package:hive_flutter/hive_flutter.dart';

part 'tag_type.g.dart';

@HiveType(typeId: 2)
enum TagType {
  @HiveField(0)
  today(0xFF00B3E6, '오늘'), // 🌞

  @HiveField(1)
  watering(0xFF4361ee, '물'), // 💦

  @HiveField(2)
  feeding(0xFFcb997e, '비료'), // 🍔

  @HiveField(3)
  potChanging(0xFFF4C095, '분갈이'), // 🪴

  @HiveField(4)
  newLeaf(0xFF6a994e, '신엽'), // 🍃

  @HiveField(5)
  flower(0xFFFFFF99, '개화'), // 🌹

  @HiveField(6)
  suffering(0xFF991AFF, '병충해'), //🐛

  @HiveField(7)
  pesticide(0xFFED2F36, '농약'), // ☣️

  @HiveField(8)
  germinated(0xFF00E680, '발아'), // 🌱

  @HiveField(9)
  seeding(0xFF582f0e, '파종'); // 🚜

  const TagType(this.color, this.translateKR);

  final int color;
  final String translateKR;
}
