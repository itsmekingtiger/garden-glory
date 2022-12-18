import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/views/main_page.dart';
import 'package:brown_brown/views/plants_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RootPage extends ConsumerStatefulWidget {
  static const pageUrl = '/root_page';

  const RootPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Plant> plants = ref.watch(plantListProvider);

    return Scaffold(
      appBar: drawAppBar(context, 'Garden Glory'),
      drawer: drawDrawer(),
      body: [MainPage(), PlantsPage()][pageIndex],
      bottomNavigationBar: drawNavigationBar(),
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
      title: Text(title,
          style: GoogleFonts.poiretOne().copyWith(
            fontSize: 36,
            color: Colors.black,
            // fontWeight: FontWeight.w800,
          )),
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
              ListTile(title: Text('설정'), onTap: () {}),
              ListTile(title: Text('로그'), onTap: () {}),

              // Import and Export
            ],
          ),

          // Server Client State
        ],
      ),
    );
  }

  Widget drawNavigationBar() {
    return NavigationBar(
      selectedIndex: pageIndex,
      destinations: const [
        NavigationDestination(icon: Icon(CupertinoIcons.sparkles), label: '홈'),
        NavigationDestination(icon: Icon(CupertinoIcons.tree), label: '내 식물'),
        NavigationDestination(icon: Icon(CupertinoIcons.calendar), label: '캘린더'),
      ],
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: (index) => setState(() => pageIndex = index),
    );
  }
}
