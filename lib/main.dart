import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_image_crud/providers/home_provider.dart';
import 'package:sqlite_image_crud/screens/home_screen.dart';

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeProvider(),)
  ],child: MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
