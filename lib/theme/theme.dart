import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './theme_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Theme Change Example',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Change Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Switch(
                    value: _themeController.isDarkMode.value,
                    onChanged: (value) {
                      _themeController.toggleTheme();
                    },
                  )),
              const SizedBox(height: 20),
              Text(
                _themeController.isDarkMode.value ? 'Dark Mode' : 'Light Mode',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
