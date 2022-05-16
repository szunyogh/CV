import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData();

const blueColor = Color(0xFF0575E6);
const greenColor = Color(0xFF00F260);

final customTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: Colors.grey[100],
  primaryColor: Colors.grey[100],
  colorScheme: theme.colorScheme.copyWith(primary: Colors.grey[400]!),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  textTheme: TextTheme(
    bodyText2: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
    ),
    bodyText1: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
    ),
    subtitle2: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
    ),
    subtitle1: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 16, color: Colors.black),
    ),
    headline1: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.w700),
    ),
    headline2: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
    ),
    headline6: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
    ),
    button: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),
    ),
    contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    fillColor: Colors.grey[200],
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(25),
    ),
  ),
  cardTheme: CardTheme(
    margin: EdgeInsets.zero,
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.red,
    contentTextStyle: GoogleFonts.oswald(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
    ),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(BorderSide.none),
      padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(25, 10, 25, 10)),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(25, 10, 25, 10)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(blueColor),
    ),
  ),
  drawerTheme: const DrawerThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(35))),
  ),
);
