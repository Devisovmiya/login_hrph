import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/hivemodels/notes/notesdata.dart';
import 'package:login_hrph/hivemodels/task/taskdata.dart';
import 'package:login_hrph/riverpod_provider/authgate.dart';
import 'package:login_hrph/riverpod_provider/provider/auth_provider/theme_auth_provider.dart';
import 'package:login_hrph/theme/darkmode.dart';
import 'package:login_hrph/theme/lightmode.dart';
import 'package:login_hrph/hivemodels/user/usermodel.dart';

void main() async {
  //initialize Hive
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  //regiter adapter
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskDataAdapter());
  Hive.registerAdapter(NotesDataAdapter());

  //Opening hive box
  await Hive.openBox('auth');
  //opening hive tasksbox
  await Hive.openBox<TaskData>('tasks');

  //opening hive notesbox
  await Hive.openBox<NotesData>('notesbox');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode(),
      darkTheme: darkMode(),

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
     // home: HomeScreen(),
      home: AuthGate(),
    );
  }
}
