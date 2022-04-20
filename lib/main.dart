import 'package:flutter/material.dart';
import 'package:shutter_api/models/hmodel.dart';
import 'home.dart';
// import 'package:path_provider/path_provider.dart' as path;
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final dir = path.getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.registerAdapter(hmodelAdapter());
  // var hbox =
  await Hive.openBox<hmodel>("HiveModalBox");

  // if (hmodel.isOpen) {
  //   print("open");
  // } else {
  //   print("closed");
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShutterStock Api Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const home(),
    );
  }
}
