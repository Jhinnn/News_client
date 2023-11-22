import 'dart:io';
import 'package:data_statistics/db/db_helper.dart';
import 'package:data_statistics/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  await DbHelper().getDb();
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(960, 680),
      center: false,
      skipTaskbar: true,
      title: 'Today News',
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: true
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
              labelSmall: TextStyle(fontSize: 9, fontWeight: FontWeight.w200, color: Colors.black54),
              bodyLarge: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w800),
              bodyMedium: TextStyle(fontSize: 11, color: Colors.black45))),
      home: const HomePage(),
    );
  }
}
