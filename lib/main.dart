import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '/src/domain/repo/task_repo.dart';

import '/src/presentation/task_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,

      home: FutureBuilder<TaskRepo>(
        future: TaskRepo.create(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.error != null) {
            return Material(
              child: Center(child: Text(asyncSnapshot.error.toString())),
            );
          }

          if (asyncSnapshot.data == null) return Material(child: Center(child: CircularProgressIndicator()));

          return TaskPage(taskRepo: asyncSnapshot.data!);
        },
      ),
    );
  }
}
