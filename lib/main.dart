import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_textos/components/TextListScreen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

Future<void> main() async {
  print('Initializing.');
  WidgetsFlutterBinding.ensureInitialized();
  await Future<void>.delayed(const Duration(milliseconds: 250));
  print('Done.');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeData>(
        future: _loadTheme(),
        builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
          return DynamicTheme(
              defaultBrightness: Brightness.light,
              data: (Brightness brightness) => snapshot.data,
              themedWidgetBuilder: (BuildContext context, ThemeData theme) {
                return MaterialApp(
                  title: 'Rafflers',
                  theme: theme,
                  home: TextListScreen(title: 'Rafflers'),
                );
              });
        });
  }

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Sorteador de textos',
  //     theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //         accentColor: Colors.pink,
  //         visualDensity: VisualDensity.adaptivePlatformDensity,
  //         fontFamily: 'RobotoCondensed',
  //         buttonTheme: ButtonThemeData(
  //           buttonColor: Colors.blue,
  //           shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(5.0))),
  //           textTheme: ButtonTextTheme.primary,
  //         )

  //         // Define the default TextTheme. Use this to specify the default
  //         // text styling for headlines, titles, bodies of text, and more.
  //         // textTheme: TextTheme(
  //         //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  //         //   headline6:
  //         //       const TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  //         //   bodyText2: const TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  //         // ),
  //         ),
  //     home: TextListScreen(title: 'Text and number sorter'),
  //   );
  // }

  Color hexToColor(String hexValue, Color defaultValue) {
    if (hexValue == null || hexValue == 'null' || hexValue.isEmpty) {
      return defaultValue;
    }
    final String valueString =
        hexValue.split('(0x')[1].split(')')[0]; // kind of hacky..
    final int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  Future<ThemeData> _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Color primaryColor =
        hexToColor(prefs.getString('primaryColor'), Colors.blue);
    final Color accentColor =
        hexToColor(prefs.getString('accentColor'), Colors.pink);

    return ThemeData(
        fontFamily: 'RobotoCondensed',
        // primarySwatch: Colors.yellow,
        primaryColor: primaryColor,
        accentColor: accentColor,
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          textTheme: ButtonTextTheme.primary,
        ));
  }
}
