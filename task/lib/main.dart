import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task/services/edit_page_provider.dart';
import 'package:task/services/home_provider.dart';
import 'package:task/views/home_page_view.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<EditPageProvider>(create: (BuildContext context) => EditPageProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (BuildContext context) => HomeProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageView()
    );
  }
}


