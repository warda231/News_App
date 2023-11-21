import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/ThemeController.dart';
import 'package:news_app/Views/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    
    GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
        //theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      //themeMode: ThemeMode.system,
       theme: ThemeData(
       useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
