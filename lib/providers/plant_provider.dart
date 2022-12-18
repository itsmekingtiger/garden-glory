import 'dart:io';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final plantListProvider = StateNotifierProvider<PlantList, List<Plant>>((ref) {
  return PlantList(const []);
});

final needToWateringProvider = Provider<List<Plant>>((ref) {
  final plants = ref.watch(plantListProvider);

  return plants.where((plant) => plant.needToWatering(kEndOfToday)).toList();
});

class PlantList extends StateNotifier<List<Plant>> {
  PlantList([List<Plant>? initialTodos]) : super(initialTodos ?? []);

  void add({
    required String name,
    required int wateringEvery,
    File? profileImage,
  }) {
    state = [
      ...state,
      Plant(
        id: _uuid.v4(),
        name: name,
        logs: const [],
        wateringEvery: wateringEvery,
        profileImage: profileImage,
      ),
    ];
  }

  void editPlantDetail({
    required String id,
    String? name,
    int? wateringEvery,
    File? profileImage,
  }) {
    state = [
      for (final plant in state)
        if (plant.id == id)
          plant.copyWith(
            name: name ?? plant.name,
            wateringEvery: wateringEvery ?? plant.wateringEvery,
            profileImage: profileImage ?? plant.profileImage,
          )
        else
          plant,
    ];
  }

  void addLog({
    required String plantId,
    required String description,
    required Set<TagType> tagType,
    required DateTime createdAt,
    File? image,
  }) {
    final log = PlantLog(id: _uuid.v4(), text: description, tagType: tagType, createdAt: createdAt, image: image);

    state = [
      for (final plant in state)
        if (plant.id == plantId) plant.copyWith(logs: [...plant.logs, log]) else plant,
    ];
  }

  void remove(Plant target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
