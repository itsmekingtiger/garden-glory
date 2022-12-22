import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/entities/plantlog.dart';
import 'package:brown_brown/entities/tag_type.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final plantListProvider = StateNotifierProvider<PlantList, List<Plant>>((ref) {
  return PlantList(Hive.box('plantBox').values.cast<Plant>().toList());
});

final needToWateringProvider = Provider<List<Plant>>((ref) {
  final plants = ref.watch(plantListProvider);

  return plants.where((plant) => plant.needToWatering(kEndOfToday)).toList();
});

class PlantList extends StateNotifier<List<Plant>> {
  PlantList([List<Plant>? plants]) : super(plants ?? []);

  void addPlant({
    required String name,
    required int wateringEvery,
    String? profileImage,
  }) {
    final newPlant = Plant(
      id: _uuid.v4(),
      name: name,
      logs: const [],
      wateringEvery: wateringEvery,
      profileImage: profileImage,
    );
    state = [...state, newPlant];
    Hive.box('plantBox').put(newPlant.id, newPlant);
  }

  void editPlant({
    required String id,
    String? name,
    int? wateringEvery,
    String? profileImage,
  }) {
    final origin = state.firstWhere((element) => element.id == id);
    final edited = origin.copyWith(
      name: name,
      wateringEvery: wateringEvery,
      profileImage: profileImage,
    );

    state = [
      for (final plant in state)
        if (plant.id == id) edited else plant,
    ];
    Hive.box('plantBox').put(edited.id, edited);
  }

  void removePlant(Plant target) {
    state = state.where((plant) => plant.id != target.id).toList();
    Hive.box('plantBox').delete(target.id);
  }

  void addLog({
    required String plantId,
    required String description,
    required Set<TagType> tags,
    required DateTime createdAt,
    String? image,
  }) {
    final newLog = PlantLog(id: _uuid.v4(), text: description, tags: tags, createdAt: createdAt, image: image);

    final oldPlant = state.firstWhere((p) => p.id == plantId);
    final newPlant =
        oldPlant.copyWith(logs: [...oldPlant.logs, newLog]..sort((a, b) => a.createdAt.difference(b.createdAt).inDays));

    state = [
      for (final plant in state)
        if (plant.id == plantId) newPlant else plant,
    ];

    Hive.box('plantBox').put(plantId, newPlant);
  }

  void editLog({
    required Plant plant,
    required PlantLog log,
    required String description,
    required Set<TagType> tags,
    required DateTime createdAt,
    String? image,
  }) {
    final pid = plant.id;
    final newLog = PlantLog(id: log.id, text: description, tags: tags, createdAt: createdAt, image: image);

    final newPlant =
        plant.copyWith(logs: [...plant.logs, newLog]..sort((a, b) => a.createdAt.difference(b.createdAt).inDays));

    state = [
      for (final plant in state)
        if (plant.id == pid) newPlant else plant,
    ];

    state = state;
    Hive.box('plantBox').put(plant.id, newPlant);
  }

  void removeLog({
    required Plant plant,
    required PlantLog log,
  }) {
    final pId = plant.id;
    plant.logs.remove(log);

    final newPlant = plant.copyWith(logs: plant.logs);
    state = [
      for (final plant in state)
        if (plant.id == pId) newPlant else plant,
    ];
    Hive.box('plantBox').put(plant.id, newPlant);
  }
}
