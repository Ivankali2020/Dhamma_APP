import '../Provider/SearchProvider.dart';
import '../Provider/AudioProvider.dart';
import '../Provider/BlogProvider.dart';
import '../Provider/MusicProvider.dart';
import '../Provider/PdfProvider.dart';
import '../Provider/VideoProvider.dart';

import '../Provider/DataProvider.dart';
import '../Screen/Main.dart';

import '../Provider/NavProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavProvider()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(create: (context) => VideoProvider()),
        ChangeNotifierProvider(create: (context) => PdfProvider()),
        ChangeNotifierProvider(create: (context) => BlogProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProxyProvider<DataProvider,MusicProvider>(create: (context) => MusicProvider([]),update: (context, value, previous) => MusicProvider(value.audioMedias),),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
        home: const Scaffold(
          body: Main(),
        ),
        // routes: {'videoDetail': (context) => VideoDetail()},
      ),

    );
  }
}
