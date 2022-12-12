import 'package:brown_brown/entity/plant.dart';

class ScheduleItem {
  String name;
  String description;
}

class PeriodicScheduleItem extends ScheduleItem {
  Duration duration;
}

class OneshotScheduleItem extends ScheduleItem {
  DateTime dateTime;
  bool done;
}

class PeriodicPlantScheduleItem extends PeriodicScheduleItem {
  Plant plant;
}

class OneshotPlantScheduleItem extends OneshotScheduleItem {
  Plant plant;
}
