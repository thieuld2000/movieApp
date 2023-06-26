import 'package:flutter/material.dart';
import 'package:movie_app/src/ui/bottom_nav_bar.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // var dir = await getApplicationDocumentsDirectory();
  // await Hive.initFlutter(dir.path);
  // await Hive.openBox('Movies');
  // await Hive.openBox('ADD');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
