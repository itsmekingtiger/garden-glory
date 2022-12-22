import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/entities/plantlog.dart';
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

  void addPlant({
    required String name,
    required int wateringEvery,
    String? profileImage,
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

  void editPlant({
    required String id,
    String? name,
    int? wateringEvery,
    String? profileImage,
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

  void removePlant(Plant target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }

  void addLog({
    required String plantId,
    required String description,
    required Set<TagType> tagType,
    required DateTime createdAt,
    String? image,
  }) {
    final log = PlantLog(id: _uuid.v4(), text: description, tagType: tagType, createdAt: createdAt, image: image);

    state = [
      for (final plant in state)
        if (plant.id == plantId)
          plant.copyWith(logs: [...plant.logs, log]..sort((a, b) => a.createdAt.difference(b.createdAt).inDays))
        else
          plant,
    ];
  }

  void editLog({
    required Plant plant,
    required PlantLog log,
    required String description,
    required Set<TagType> tagType,
    required DateTime createdAt,
    String? image,
  }) {
    final pid = plant.id;
    final newLog = PlantLog(id: log.id, text: description, tagType: tagType, createdAt: createdAt, image: image);

    state = [
      for (final plant in state)
        if (plant.id == pid)
          plant.copyWith(
            logs: [...plant.logs..remove(log), newLog]..sort((a, b) => a.createdAt.difference(b.createdAt).inDays),
          )
        else
          plant,
    ];

    state = state;
  }

  void removeLog({
    required Plant plant,
    required PlantLog log,
  }) {
    final pId = plant.id;
    plant.logs.remove(log);

    state = [
      for (final plant in state)
        if (plant.id == pId) plant.copyWith(logs: plant.logs) else plant,
    ];
  }
}
