import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/provider/items_provider.dart';
import 'package:state_management_provider/services/api_servies.dart';
import 'package:state_management_provider/views/homepage_view.dart';

void main() {
  runApp(ChangeNotifierProvider<ItemProvider>(
    child: const MyApp(),
    create: (_) => ItemProvider(), // Create a new ChangeNotifier object
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}
