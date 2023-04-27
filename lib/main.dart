import 'package:flutter/material.dart';
import 'package:geopic/feature/select_image/select_image_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'di/di.dart';

void main() {
  GetIt.I.allowReassignment = true;
  configureDependencies();
  dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SelectImageScreen(),
    );
  }
}
