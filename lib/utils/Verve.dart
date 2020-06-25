//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

library verve;

import 'package:flutter/material.dart';

// ///Default VerveTextTheme...
// const TextTheme VerveTextTheme = TextTheme(
//   display4: TextStyle(
//     fontFamily: 'Metropolis',
//     fontSize: 96.0,
//     fontWeight: FontWeight.w300,
//     letterSpacing: -1.5,
//   ),
//   display3: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 60.0,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -0.5),
//   display2: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 48.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.0),
//   display1: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 34.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25),
//   headline: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 24.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.0),
//   title: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 20.0,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.15),
//   subhead: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 16.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.15),
//   body2: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 14.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25),
//   body1: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 16.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.5),
//   button: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 14.0,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.75),
//   caption: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 12.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.4),
//   subtitle: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 14.0,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.1),
//   overline: TextStyle(
//       fontFamily: 'Metropolis',
//       fontSize: 10.0,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5),
// );

class ThemeColors {
  ThemeColors(this.main, this.accent);
  Color main;
  Color accent;
}

/// Uses a VerveTheme to reform a ThemeData with relevant colors.
///
/// Also updates ThemeData to use MaterialDesign 2018 specification for
/// text, as opposed to the current 2014 specification.
// ThemeData verveSwatch({@required VerveTheme theme, ThemeData base}) {
//   base ??= ThemeData();
//   Color bg;
//   Color accent;
//   Color main;
//   switch (theme) {
//     case VerveTheme.amati:
//       {
//         main = const Color(0xff45757D);
//         accent = const Color(0xff27455C);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.dark,
//           accentColorBrightness: Brightness.dark,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.blue:
//       {
//         main = const Color(0xff2787B7);
//         accent = const Color(0xff024669);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.dark,
//           accentColorBrightness: Brightness.dark,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.purple:
//       {
//         main = const Color(0xff73305B);
//         accent = const Color(0xff272640);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.dark,
//           accentColorBrightness: Brightness.dark,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.venice:
//       {
//         main = const Color(0xff0396A6);
//         accent = const Color(0xffF25E5E);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.dark,
//           accentColorBrightness: Brightness.dark,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.twilight:
//       {
//         main = const Color(0xff192853);
//         accent = const Color(0xffffffff);
//         bg = const Color(0xff0C1A3D);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.light,
//           accentColorBrightness: Brightness.dark,
//           brightness: Brightness.dark,
//         );
//       }
//       break;
//     case VerveTheme.beach:
//       {
//         main = const Color(0xff046380);
//         accent = const Color(0xffE6E2AF);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.light,
//           accentColorBrightness: Brightness.dark,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.darkMode:
//       {
//         return ThemeData.dark();
//         /* .copy copyWith(
//           textTheme: VerveTextTheme,
//         ); */
//       }
//       break;
//     case VerveTheme.garden:
//       {
//         main = const Color(0xff4BB5C1);
//         accent = const Color(0xffB5E655);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.light,
//           accentColorBrightness: Brightness.light,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.navy:
//       {
//         main = const Color(0xff2C3E50);
//         accent = const Color(0xffFC4349);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.dark,
//           accentColorBrightness: Brightness.dark,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.sepia:
//       {
//         main = const Color(0xff1A9481);
//         accent = const Color(0xff9BCC93);
//         bg = const Color(0xffffffff);
//         base = base.copyWith(
//           primaryColorBrightness: Brightness.dark,
//           accentColorBrightness: Brightness.light,
//           brightness: Brightness.light,
//         );
//       }
//       break;
//     case VerveTheme.material:
//       {
//         return ThemeData.light();
//         /* .copyWith(
//           textTheme: VerveTextTheme,
//         ); */
//       }
//       break;
//   }
//   base = base.copyWith(
//       primaryColor: main,
//       accentColor: accent,
//       backgroundColor: bg,
//       scaffoldBackgroundColor: bg,
//       buttonColor: accent,
//       buttonTheme: ButtonThemeData(
//         buttonColor: accent,
//         hoverColor: main,
//         splashColor: main,
//         textTheme: ButtonTextTheme.normal,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//       ),
//       cardTheme: CardTheme(
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5)),
//         color: bg,
//       ),
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: accent,
//         foregroundColor: bg,
//         splashColor: main,
//         hoverColor: main,
//       ),
//       appBarTheme: AppBarTheme(brightness: base.primaryColorBrightness));
//   // , textTheme: VerveTextTheme);
//   return base;
// }

ThemeColors getVerveColors({@required VerveTheme theme}) {
  Color bg;
  Color accent;
  Color main;
  switch (theme) {
    case VerveTheme.amati:
      {
        main = const Color(0xff45757D);
        accent = const Color(0xff27455C);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.blue:
      {
        main = const Color(0xff2787B7);
        accent = const Color(0xff024669);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.purple:
      {
        main = const Color(0xff73305B);
        accent = const Color(0xff272640);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.venice:
      {
        main = const Color(0xff0396A6);
        accent = const Color(0xffF25E5E);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.twilight:
      {
        main = const Color(0xff192853);
        accent = const Color(0xffffffff);
        bg = const Color(0xff0C1A3D);
      }
      break;
    case VerveTheme.beach:
      {
        main = const Color(0xff046380);
        accent = const Color(0xffE6E2AF);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.darkMode:
      {
        main = ThemeData.dark().primaryColor;
        accent = ThemeData.dark().accentColor;
      }
      break;
    case VerveTheme.garden:
      {
        main = const Color(0xff4BB5C1);
        accent = const Color(0xffB5E655);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.navy:
      {
        main = const Color(0xff2C3E50);
        accent = const Color(0xffFC4349);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.sepia:
      {
        main = const Color(0xff1A9481);
        accent = const Color(0xff9BCC93);
        bg = const Color(0xffffffff);
      }
      break;
    case VerveTheme.material:
      {
        main = ThemeData.light().primaryColor;
        accent = ThemeData.light().accentColor;
      }
      break;
  }
  return ThemeColors(main, accent);
}

///Different themes available for [verveSwatch].
enum VerveTheme {
  material,
  amati,
  venice,
  blue,
  purple,
  twilight,
  beach,
  darkMode,
  garden,
  navy,
  sepia,
}
