import 'package:flutter/material.dart';
import 'package:world_country/screens/country_search_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country Search',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const CountrySearchScreen(),
    );
  }
}
