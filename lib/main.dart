import 'package:epaper/const.dart';
import 'package:epaper/direction.dart';
import 'package:epaper/model/newspaper_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(NewspaperModelAdapter());
  Hive.openBox<NewspaperModel>(newspaperBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Direction(),
    );
  }
}
