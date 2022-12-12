import 'package:brown_brown/entity/plant.dart';

class PlantLogEntry {
  int id;
  Plant plant;
  String? photo;
  String description;
  DateTime writtenAt;
  Set<LogType> types;
}

enum LogType {
  theNew, // 입양
  gone, // 쓰봉
  seeding, // 파종
  germinated, // 발아
  potChanging, // 분갈이
  today, //오늘의 모습
  newLeaf, // 신엽
  flower, // florescence, 개화
  suffering, // 병충해
  watering, // 물주기
  feeding, // 비료
  other, // 기타
}
