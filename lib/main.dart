// Core Flutter Material Design package
import 'package:flutter/material.dart';
// Package for responsive UI and screen size adaptation
import 'package:flutter_screenutil/flutter_screenutil.dart';
// App-wide constants (colors, theme values, etc.)
import 'package:foodly_app/constants/constants.dart';
// Main navigation structure of the app
import 'package:foodly_app/views/entrypoint.dart';
// GetX state management package
import 'package:get/get.dart';

// Define the default home screen of the app
Widget defaultHome = MainScreen(); // The main screen with bottom navigation

/// Entry point of the application
void main() {
  runApp(const MyApp());
}

/// Root widget of the Foodly application
/// This widget sets up the basic app configuration including:
/// - Screen size adaptation
/// - Theme configuration
/// - Navigation setup with GetX
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Set the design size for responsive scaling
      // This matches the design specifications (e.g., from Figma)
      designSize: const Size(375, 825),
      minTextAdapt: true,  // Automatically adapt text size
      splitScreenMode: true, // Support split screen mode
      // Builder provides the configured context to the app
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false, // Remove debug banner
          title: 'Foodly App',
          // App-wide theme configuration
          theme: ThemeData(
            scaffoldBackgroundColor: kOffWhite, // Background color for all screens
            iconTheme: const IconThemeData(
              color: kDark, // Default icon color
            ),
            primarySwatch: Colors.grey // Primary color palette
          ),
          home: defaultHome, // Set the initial screen (MainScreen)
        );
      },
    );
  }
}

/// Default Flutter counter page (can be removed if not needed)
/// This is the template page that comes with new Flutter projects
/// Note: This page is currently not being used as we're using MainScreen as our home page
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // The title of the page, passed in from the parent widget
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// State class for the MyHomePage widget
/// Note: This is template code and can be removed if not needed
class _MyHomePageState extends State<MyHomePage> {
  // Counter variable to demonstrate state management
  int _counter = 0;

  // Method to increment the counter and trigger a UI update
  void _incrementCounter() {
    setState(() {
      // Update the counter value and rebuild the UI
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
