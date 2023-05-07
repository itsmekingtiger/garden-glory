import 'dart:io';

import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/entities/tag_type.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/utils/datetime_helper.dart';
import 'package:brown_brown/views/plant_log_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage extends ConsumerWidget {
  static const pageUrl = '/main';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> needWaterings = ref.watch(needToWateringProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Watering Notification Section

          if (needWaterings.isNotEmpty)
            Container(
              padding: EdgeInsets.all(Insets.lg),
              alignment: Alignment.center,
              child: Text('물주기를 기다리고 있어요', style: Theme.of(context).textTheme.headlineSmall),
            ),

          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              clipBehavior: Clip.none,
              enableInfiniteScroll: false,
            ),
            items: needWaterings.map((plant) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                        PlantLogEditPage.pageUrl,
                        arguments: {'plant': plant},
                      ),
                      child: ClipRRect(
                        borderRadius: Corners.mdBorder,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (plant.profileImage != null)
                                  Image(height: 400.0, image: FileImage(File(plant.profileImage!)), fit: BoxFit.cover),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      plant.name,
                                      style: TextStyles.headerInversed.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      dateAgo(plant.nextWatring!, DateTime.now()),
                                      style: TextStyles.headerInversed.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 9),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.black,
                                        textStyle: TextStyles.headerInversed,
                                      ),
                                      child: Text('Watering now'),
                                      onPressed: () {
                                        ref.watch(plantListProvider.notifier).addLog(
                                              plantId: plant.id,
                                              description: '물과 비료을 줬어요',
                                              tags: {TagType.watering, TagType.feeding},
                                              createdAt: DateTime.now(),
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // Long time no see section
        ],
      ),
    );
  }
}
