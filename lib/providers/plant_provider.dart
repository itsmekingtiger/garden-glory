import 'dart:io';

import 'package:brown_brown/entities/plant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final plantListProvider = StateNotifierProvider<PlantList, List<Plant>>((ref) {
  return PlantList(const []);
});

final needToWateringProvider = Provider<List<Plant>>((ref) {
  final plants = ref.watch(plantListProvider);

  var today = DateTime.now();
  return plants.where((plant) => plant.needToWatering(today)).toList();
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
        wateringEvery: 0,
        profileImage: profileImage,
      ),
    ];
  }

  void edit({
    required String id,
    String? name,
    int? wateringEvery,
    File? profileImage,
  }) {
    state = [
      for (final plant in state)
        if (plant.id == id)
          Plant(
            id: plant.id,
            name: name ?? plant.name,
            logs: plant.logs,
            wateringEvery: wateringEvery ?? plant.wateringEvery,
            profileImage: profileImage ?? plant.profileImage,
          )
        else
          plant,
    ];
  }

  void addLog({
    required String id,
    required PlantLog log,
  }) {
    state = [
      for (final plant in state)
        if (plant.id == id)
          Plant(
            id: plant.id,
            name: plant.name,
            logs: [...plant.logs, log],
            wateringEvery: plant.wateringEvery,
          )
        else
          plant,
    ];
  }

  void remove(Plant target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
