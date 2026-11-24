import 'package:business_card/helper/hive_helper.dart';
import 'package:business_card/model/note.dart';
import 'package:business_card/screens/home%20screen.dart';
import 'package:business_card/screens/splash%20screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ColorAdapter());
  await Hive.openBox(HiveHelper.noteBox);

  HiveHelper.getNotes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return (GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ));
  }
}
