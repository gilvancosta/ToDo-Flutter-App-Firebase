import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData get theme => ThemeData(
           textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: const Color(0xff5C77CE),
        primaryColorLight: const Color.fromARGB(255, 63, 64, 153),
        indicatorColor: const Color.fromARGB(255, 148, 105, 95),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff5C77CE)),
        ),
      );
}
