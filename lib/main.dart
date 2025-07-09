import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_image_app/view/screens/counter_example/counter_screen_add2.dart';
import 'package:test_image_app/view/screens/home_screen.dart';
import 'package:test_image_app/view/screens/pokemon_list/pokemon_list_stateful_screen.dart';
import 'package:test_image_app/view/screens/pokemon_list/pokemon_list_stateless_screen.dart';
import 'package:test_image_app/view/screens/picker_image/picker_image_screen.dart';
import 'package:test_image_app/view_model/counter_example/counter_add2_view_model.dart';
import 'package:test_image_app/view_model/counter_view_model.dart';
import 'package:test_image_app/view_model/picker_image/picker_image_view_model.dart';
import 'package:test_image_app/view_model/pokemon_list/pokemon_list_view_model.dart';

void main() {
  // if need to use global state management, use MultiProvider
  /*
  runApp(
    // if need global state management, use MultiProvider
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => CounterViewModel()),
        //ChangeNotifierProvider(create: (_) => CounterAdd2ViewModel()),
      ],
      child: const MyApp(),
    ),
  );
  */
  // If you want to use ChangeNotifierProvider for each screen, you can do it in the routes
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/': (context) => ChangeNotifierProvider(
          create: (_) => CounterViewModel(),
          child: const HomeScreen(),
        ),
        // if need reset state management, use ChangeNotifierProvider
        // When navigating to the '/counter_add2' route, build the CounterScreenAdd2 widget.
        '/counter_add2': (context) => ChangeNotifierProvider(
          create: (_) => CounterAdd2ViewModel(),
          child: const CounterScreenAdd2(),
        ),
        '/pokemon_list_stateless': (context) => ChangeNotifierProvider(
          create: (_) => PokemonListViewModel(),
          child: const PokemonListStatelessScreen(),
        ),
        '/pokemon_list_steteful': (context) => const PokemonListStatefulScreen(),
        '/picker_image': (context) => ChangeNotifierProvider(
          create: (_) => PickerImageViewModel(), // Example, replace with actual ViewModel if needed
          child: const PickerImageScreen(),
        )
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
