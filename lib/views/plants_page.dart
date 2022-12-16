import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/ui/styles.dart';
import 'package:brown_brown/views/nav_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantsPage extends ConsumerWidget {
  static const pageUrl = '/plants';

  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Plant> plants = ref.watch(plantListProvider);

    Widget drawWateringNotifications(List<Plant> plants) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text('오늘의 물주기', style: Theme.of(context).textTheme.bodyText2),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      bottomNavigationBar: BottomNavBar(1),
      body: Column(
        children: [
          // Create New pant button
          BrownActionButton(
            callback: () => Navigator.pushNamed(context, '/new_plant'),
            icon: Icon(Icons.add, color: Colors.grey[500]),
            child: Text('식물 추가하기', style: Theme.of(context).textTheme.bodyText2),
          ),

          // List of plants
          Expanded(
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/plant_detail'),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: plants[index].profileImage == null
                                      ? null
                                      : FileImage(plants[index].profileImage!),
                                ),
                                // name, species, last event
                                HSpace.md,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        plants[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      Text('오늘/어제/n일전, last event title here',
                                          style: Theme.of(context).textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // write log
                                  },
                                  icon: Icon(CupertinoIcons.pencil_outline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BrownActionButton extends StatelessWidget {
  const BrownActionButton({
    Key? key,
    required this.callback,
    required this.child,
    this.icon,
  }) : super(key: key);

  final VoidCallback callback;
  final Widget child;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(margin: EdgeInsets.all(10), child: child),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: icon,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
