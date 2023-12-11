import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todoapp/providers/data_provider.dart';
import 'package:todoapp/views/screens/create_screen.dart';
import 'package:todoapp/views/screens/edit_screen.dart';
import 'package:todoapp/views/screens/list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );

}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ListScreen(),
        '/edit_screen': (context) => EditScreen(),
        '/creat_screen': (context) => CreateScreen(),
      },
      theme: ThemeData(primarySwatch: Colors.lightGreen),
    );
  }
}
