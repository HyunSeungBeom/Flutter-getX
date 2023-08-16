import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class TranslationController extends GetxController {
  var locale = const Locale('en', 'US').obs;

  void changeLocale(String languageCode) {
    final newLocale = Locale(languageCode);
    locale.value = newLocale;
  }

  String getTranslation(String key) {
    final translations = {
      'hello': {'en': 'Hello', 'ko': '안녕하세요'},
      'welcome': {'en': 'Welcome to the app!', 'ko': '앱에 오신 것을 환영합니다!'},
    };

    final currentTranslation = translations[key];
    if (currentTranslation != null) {
      final translation = currentTranslation[locale.value.languageCode];
      return translation ?? key;
    }

    return key;
  }
}

class MyApp extends StatelessWidget {
  final translationController = Get.put(TranslationController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Language App',
      translations: MyTranslations(),
      locale: translationController.locale.value,
      fallbackLocale: const Locale('en', 'US'),
      home: HomeScreen(),
    );
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'welcome': 'Welcome to the app!',
        },
        'ko_KR': {
          'hello': '안녕하세요',
          'welcome': '앱에 오신 것을 환영합니다!',
        },
      };
}

class HomeScreen extends StatelessWidget {
  final translationController = Get.find<TranslationController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _showLanguageDialog(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  translationController.getTranslation('hello'),
                  style: const TextStyle(fontSize: 24),
                )),
            const SizedBox(height: 20),
            Obx(() => Text(
                  translationController.getTranslation('welcome'),
                  style: const TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                translationController.changeLocale('en');
                Get.back();
              },
            ),
            ListTile(
              title: const Text('한국어'),
              onTap: () {
                translationController.changeLocale('ko');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
