import 'package:brown_brown/database/database_init.dart';
import 'package:brown_brown/providers/plant_provider.dart';
import 'package:brown_brown/views/main_page.dart';
import 'package:brown_brown/views/new_plant_page.dart';
import 'package:brown_brown/views/plant_detail_page%20copy.dart';
import 'package:brown_brown/views/plants_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // const databaseName = 'brown_brown.db';
  // final database = await openDatabase(
  //   databaseName,
  //   version: 1,
  //   onCreate: createDatabase,
  // );

  // await database.rawQuery(Queries.queriesAllPlants);
  // await database.rawQuery(Queries.queriesAllPlantLogs);

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
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/main': (context) => MainPage(),
        '/plants': (context) => PlantsPage(),
        '/new_plant': (context) => NewPlantPage(),
        '/new_plant/set_watering': (context) => NewPlanSetWateringPage(),
        '/plant_detail': (context) => PlantsDetailPage(),
      },
    );
  }
}
