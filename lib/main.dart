import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_image_app/view/screens/counter_example/counter_screen_add2.dart';
import 'package:test_image_app/view/screens/home_screen.dart';
import 'package:test_image_app/view/screens/pokemon_list/pokemon_list_stateful_screen.dart';
import 'package:test_image_app/view/screens/pokemon_list/pokemon_list_stateless_screen.dart';
import 'package:test_image_app/view/screens/picker_image/picker_image_screen.dart';
import 'package:test_image_app/view/screens/voice_record/voice_record_screen.dart';
import 'package:test_image_app/view_model/counter_example/counter_add2_view_model.dart';
import 'package:test_image_app/view_model/counter_view_model.dart';
import 'package:test_image_app/view_model/picker_image/picker_image_view_model.dart';
import 'package:test_image_app/view_model/pokemon_list/pokemon_list_view_model.dart';
import 'package:test_image_app/view_model/voice_record/voice_record_view_model.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  //Workmanager().initialize(doBackgroundSync, isInDebugMode: true); // ✅ Must be here
  //setupBackgroundSync();

  //setupBackgroundSync();
  setupBackgroundSync();
  runApp(const MyApp());
}

void setupBackgroundSync() {
  // Notes:
  // Naming conventions for WorkManager tasks:
  // [DO] Unqiue task name must camelcase and it have Task suffix.
  // For example: "backgroundSyncTask" or "simpleTask".
  // [DO] Unique identifier must be unique and can be used to identify the task.
  // For example: "task-identifier-background-sync" or "task-identifier-simple".
  const uniqueTaskName = "backgroundSyncTask";
  const uniqueIdentifier = "task-identifier-background-sync";
  const initialDelay = Duration(
    minutes: 15,
  ); // minimum 15 minutes for periodic tasks
  final constraints = Constraints(
    networkType: NetworkType.unmetered,
    requiresBatteryNotLow: true,
    requiresCharging: false,
    requiresDeviceIdle: true,
    requiresStorageNotLow: true,
  );

  Workmanager().initialize(
    doBackgroundSync, // The top level function, aka callbackDispatcher
    isInDebugMode:
        true, // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  if (Platform.isAndroid) {
    // For Android, you can register a one-off task or a periodic task
    Workmanager().registerOneOffTask(uniqueIdentifier, uniqueTaskName);
    // Periodic tasks
    /*
    Workmanager().registerPeriodicTask(
      uniqueIdentifier
      uniqueTaskName,
      frequency: initialDelay,
      initialDelay: initialDelay,
      constraints: constraints,
    );
    */
  } else if (Platform.isIOS) {
    // For iOS, you can register a one-off task
    Workmanager().registerOneOffTask(
      uniqueIdentifier,
      uniqueTaskName,
      initialDelay: initialDelay,
      constraints: constraints,
      inputData: <String, dynamic>{
        'randomNumber': Random().nextInt(1000), // Example input data
      },
    );
  } else {
    throw UnsupportedError(
      "This app is only supported on Android and iOS platforms.",
    );
  }
}

@pragma(
  'vm:entry-point',
) // Mandatory if the App is obfuscated or using Flutter 3.1+
void doBackgroundSync() {
  Workmanager().executeTask((task, inputData) {
    print(
      "Native called background task: $task",
    ); //simpleTask will be emitted here.
    return Future.value(true);
  });
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
        '/pokemon_list_steteful': (context) =>
            const PokemonListStatefulScreen(),
        '/picker_image': (context) => ChangeNotifierProvider(
          create: (_) =>
              PickerImageViewModel(), // Example, replace with actual ViewModel if needed
          child: const PickerImageScreen(),
        ),
        '/voice_record': (context) => ChangeNotifierProvider(
          create: (_) =>
              VoiceRecordViewModel(), // Example, replace with actual ViewModel if needed
          child: const VoiceRecordScreen(),
        ),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
