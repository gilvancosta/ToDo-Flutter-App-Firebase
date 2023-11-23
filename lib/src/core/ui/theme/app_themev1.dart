import 'package:flutter/material.dart';

import 'app_constantes.dart';



sealed class MyAppThemeV1 {
  static const defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(
      color: ConstantsColors.grey,
    ),
  );

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    // colorScheme: ColorScheme.fromSwatch().copyWith(primary: ConstantsColors.primaryColor, secondary: ConstantsColors.secondaryColor),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

  /*   appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: ConstantsColors.brow),
      backgroundColor: ConstantsColors.primaryColor,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.black,
        fontFamily: ConstantsFonts.fontFamilyTheme,
      ),
    ),
 */

/*     inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: ConstantsColors.grey),
      border: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      errorBorder: defaultInputBorder.copyWith(borderSide: const BorderSide(color: ConstantsColors.red)),
    ), */



 /*    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ConstantsColors.brow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ), */



    textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: const TextStyle(fontSize: 20, fontFamily: ConstantsFonts.fontFamilyText),
        ),


    canvasColor: ConstantsColors.myCanvasColor,
    fontFamily: ConstantsFonts.fontFamilyTheme,


    
  );
}
