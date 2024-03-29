import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/utils/build_info.dart';
import 'package:brown_brown/views/main_page.dart';
import 'package:brown_brown/views/mini_wiki.dart';
import 'package:brown_brown/views/plants_page.dart';
import 'package:brown_brown/views/third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootPage extends ConsumerStatefulWidget {
  static const pageUrl = '/root_page';

  const RootPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState {
  int pageIndex = 0;

  String buildInfo = 'No build info';

  @override
  void initState() {
    super.initState();
    getBuildInfo().then((info) => setState(() => buildInfo = info['commitId'] ?? 'No build info'));
  }

  @override
  Widget build(BuildContext context) {
    final bool hasNotification = ref.watch(needToWateringProvider).length > 0;

    final List<Plant> plants = ref.watch(plantListProvider);

    final fab = pageIndex == 1
        ? FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/new_plant'),
            child: Icon(Icons.add),
          )
        : null;

    return Scaffold(
      floatingActionButton: fab,
      appBar: drawAppBar(context, 'Garden Glory'),
      drawer: drawDrawer(),
      body: [MainPage(), PlantsPage(), ThirdPage()][pageIndex],
      bottomNavigationBar: drawNavigationBar(hasNotification),
    );
  }

  AppBar drawAppBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,

      // Open drawer
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),

      // TODO: App logo
      title: Text(title, style: TextStyle(fontFamily: 'PoiretOne', fontSize: 36, color: Colors.black)),
    );
  }

  Drawer drawDrawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(title: Text('Open source license'), onTap: () => showLicensePage(context: context)),
              // ListTile(title: Text('로그'), onTap: () {}),
              ListTile(title: Text('미니 위키'), onTap: () => Navigator.of(context).pushNamed(MiniWikiPage.pageUrl)),

              // Import and Export
            ],
          ),

          // Server Client State

          // Build info
          Text('build: $buildInfo', style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }

  Widget drawNavigationBar(bool hasNotification) {
    return NavigationBar(
      selectedIndex: pageIndex,
      destinations: [
        NavigationDestination(
            icon: Stack(children: [
              Icon(CupertinoIcons.bell),
              if (hasNotification)
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Icon(Icons.brightness_1, size: 8.0, color: Colors.redAccent),
                )
            ]),
            label: '알림'),
        NavigationDestination(icon: Image.asset('assets/icon/leaf.png', width: 24), label: '내 식물'),
        NavigationDestination(icon: Icon(CupertinoIcons.calendar), label: '캘린더'),
      ],
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: (index) => setState(() => pageIndex = index),
    );
  }
}
