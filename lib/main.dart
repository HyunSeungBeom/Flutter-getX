import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Counter Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CountController _countController = Get.put(CountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Count: ${_countController.count.value}')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _countController.increment,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class CountController extends GetxController {
  var count = 0.obs;

  void increment() {
    count.value++;
  }
}
