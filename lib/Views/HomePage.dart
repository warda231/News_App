import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Utils/colors.dart';
import 'package:news_app/Views/HomeScreen.dart';
import 'package:news_app/Views/SearchDetails.dart';

import '../Controller/LandingPage.dart';
import '../Controller/ThemeController.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThemeController DarkThemeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    var navbars = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: '',
      ),
    ];

    var pages = [
      HomeScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];

    var controller = Get.put(HomeController());

    return Scaffold(
     
      body: Obx(() => pages.elementAt(controller.navbarindex.value)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.navbarindex.value,
            items: navbars,
            selectedItemColor: kSecondaryColor,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.navbarindex.value = value;
            },
          )),
    );
  }
}
