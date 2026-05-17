import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/favproviders.dart';
import 'package:recipe_book/homepage.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Favproviders())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title:'Sweet Crumbs',
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
        fontFamily: 'OpenSans',
        ),
        home: Homepage(),
      ),
    );
  }
}
