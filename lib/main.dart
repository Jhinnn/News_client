import 'dart:io';
import 'package:data_statistics/db/db_helper.dart';
import 'package:data_statistics/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper().getDb();
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(720, 480),
      center: false,
      skipTaskbar: true,
      title: 'Flutter',
      titleBarStyle: TitleBarStyle.hidden,
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
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.amber,
          textTheme: const TextTheme(
              overline: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w200,
                  color: Colors.black54),
              bodyText1: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w800),
              bodyText2: TextStyle(fontSize: 10, color: Colors.black45))
      ),
      home: const HomePage(),
    );
  }
}
