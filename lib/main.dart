import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Add_note_screen.dart';
import 'package:flutter_application_1/Home_screen.dart';
import 'package:flutter_application_1/Usercreate.dart';
import 'package:flutter_application_1/firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Createpage(),
      
    );
  }
}
