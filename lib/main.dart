import 'package:flutter/material.dart';
import 'package:sorteador_textos/components/TextList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sorteador de textos',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'RobotoCondensed',
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            textTheme: ButtonTextTheme.primary,
          )

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          // textTheme: TextTheme(
          //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   headline6:
          //       const TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //   bodyText2: const TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          // ),
          ),
      home: const MyHomePage(title: 'Text and number sorter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextList textList = TextList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: textList,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          textList.raffle();
        },
        child: Icon(Icons.language),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
