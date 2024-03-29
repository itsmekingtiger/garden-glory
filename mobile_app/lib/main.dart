import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/entities/plantlog.dart';
import 'package:brown_brown/entities/tag_type.dart';
import 'package:brown_brown/views/edit_plant_page.dart';
import 'package:brown_brown/views/mini_wiki.dart';
import 'package:brown_brown/views/new_plant_page.dart';
import 'package:brown_brown/views/plant_detail_page.dart';
import 'package:brown_brown/views/plant_log_edit_page.dart';
import 'package:brown_brown/views/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlantAdapter());
  Hive.registerAdapter(PlantLogAdapter());
  Hive.registerAdapter(TagTypeAdapter());
  await Hive.openBox('plantBox');

  // database
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'brown brwon',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ko')],
      home: RootPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        RootPage.pageUrl: (context) => RootPage(),
        NewPlantPage.pageUrl: (context) => NewPlantPage(),
        NewPlanSetWateringPage.pageUrl: (context) => NewPlanSetWateringPage(),
        PlantDetailPage.pageUrl: (context) => PlantDetailPage(),
        EditPlantPage.pageUrl: (context) => EditPlantPage(plantId: _args(context, 'plantId')),
        PlantLogEditPage.pageUrl: (context) => PlantLogEditPage(
              plant: _args(context, 'plant'),
              log: _args(context, 'log'),
            ),
        MiniWikiPage.pageUrl: (context) => MiniWikiPage(),
      },
    );
  }

  _args(BuildContext context, String key) {
    return (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?)?[key];
  }
}
