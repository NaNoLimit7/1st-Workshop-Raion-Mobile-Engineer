import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workshop_1/level1/home_page_1.dart';
import 'package:workshop_1/level2/home_page_2.dart';
import 'package:workshop_1/level3/detail_screen.dart';
import 'package:workshop_1/level3/home_page_3.dart';
import 'package:workshop_1/miniproject/home_page_4.dart';
import 'package:workshop_1/miniproject/providers/product_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightGreenAccent),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: HomePage4(),
    );
  }
}
