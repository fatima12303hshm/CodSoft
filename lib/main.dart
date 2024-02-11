import 'package:flutter/material.dart';
import 'package:to_do_list/source/view/home_page.dart';
import 'package:to_do_list/source/view/welcome_page.dart';
import 'package:to_do_list/widgets/displayAll.dart';

void main()  {
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
      routes: {HomePage.routeName: (context) => const HomePage(), 
      DisplayAll.routeName: (context)=> const DisplayAll()},
    );
  }
}
