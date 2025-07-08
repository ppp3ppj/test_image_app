import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_image_app/view/screens/home_screen.dart';
import 'package:test_image_app/view_model/counter_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CounterViewModel())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        // When navigating to the "/" route, build the MyHomePage widget.
        //'/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/': (context) => HomeScreen(),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}