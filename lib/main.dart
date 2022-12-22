import 'package:brown_brown/entities/plant.dart';
import 'package:brown_brown/views/edit_plant_page.dart';
import 'package:brown_brown/views/new_plant_page.dart';
import 'package:brown_brown/views/plant_detail_page.dart';
import 'package:brown_brown/views/plant_log_edit_page.dart';
import 'package:brown_brown/views/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlantAdapter());
  await Hive.openBox<PlantAdapter>('plantBox');

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
        textTheme: GoogleFonts.nanumGothicTextTheme(),
      ),
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
      },
    );
  }

  _args(BuildContext context, String key) {
    return (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?)?[key];
  }
}
