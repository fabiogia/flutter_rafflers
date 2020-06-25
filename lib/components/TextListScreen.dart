import 'dart:math';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorteador_textos/components/RaffleResult.dart';
import 'package:sorteador_textos/components/two_colors_picker/colors.dart';
import 'package:sorteador_textos/components/two_colors_picker/two_colors_picker.dart';
import 'package:sorteador_textos/utils/DialogUtils.dart';
import 'package:sorteador_textos/utils/Verve.dart';

class TextListScreen extends StatefulWidget {
  TextListScreen({this.title});

  _TextListScreenState state;

  @override
  _TextListScreenState createState() {
    state = _TextListScreenState();
    return state;
  }

  String title;
}

class _TextListScreenState extends State<TextListScreen> {
  final TextEditingController textController = TextEditingController();

  final List<String> items = <String>[];
  // List<String>.generate(20, (int i) => 'Item ${i + 1}');

  String itemRemoved = '';

  List<PopupMenuEntry<String>> _menuPopupItems;

  @override
  void initState() {
    _menuPopupItems = <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'main',
        child: Text('Change main color'),
      ),
      const PopupMenuItem<String>(
        value: 'accent',
        child: Text('Change accent color'),
      ),
      const PopupMenuItem<String>(
        value: 'combos',
        child: Text('2 colors combination'),
      ),
    ];

    // for (int v = 0; v < VerveTheme.values.length; v++) {
    //   final VerveTheme useTheme = VerveTheme.values[v];
    //   ThemeColors themeColors = getVerveColors(theme: useTheme);

    //   _menuPopupItems.add(PopupMenuItem<String>(
    //       value: useTheme.toString(),
    //       child: Row(children: <Widget>[
    //         Container(
    //           width: 30,
    //           height: 30,
    //           color: themeColors.main,
    //         ),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         Container(
    //           width: 30,
    //           height: 30,
    //           color: themeColors.accent,
    //         ),
    //       ])
    //       // Text(element.toString()),
    //       ));
    // }

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => _menuPopupItems,
          onSelected: (String result) {
            if (result == 'main') {
              _openMainColorPicker();
            } else if (result == 'accent') {
              _openAccentColorPicker();
            } else if (result == 'combos') {
              _openCombosPicker();
            }

            // switch (result) {
            //   case 'main':
            //     _openMainColorPicker();
            //     break;
            //   case 'accent':
            //     _openAccentColorPicker();
            //     break;
            // }
          },
        )
        // IconButton(
        //     icon: const Icon(Icons.color_lens),
        //     onPressed: () {
        //       DialogUtils.hideKeyboard(context);

        //     }),
      ]),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          raffle();
        },
        child: Icon(Icons.language),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  void _openDialog(String title, Widget content) {
    showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: const Text('SUBMIT'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _saveColors();
                DynamicTheme.of(context).setThemeData(ThemeData(
                    primaryColor: _tempMainColor,
                    accentColor: _tempShadeColor));
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  // ColorSwatch<dynamic> _tempMainColor;
  Color _tempMainColor;
  Color _tempShadeColor;

  Future<void> _openMainColorPicker() async {
    _openDialog(
      'Main Color picker',
      MaterialColorPicker(
          selectedColor: Theme.of(context).primaryColor,
          allowShades: false,
          onMainColorChange: (ColorSwatch<dynamic> color) =>
              setState(() => _tempMainColor = color)),
    );
  }

  Future<void> _openAccentColorPicker() async {
    _openDialog(
      'Accent Color picker',
      MaterialColorPicker(
        colors: accentColors,
        selectedColor: Theme.of(context).accentColor,
        onMainColorChange: (ColorSwatch<dynamic> color) =>
            setState(() => _tempShadeColor = color),
        circleSize: 40.0,
        spacing: 10,
      ),
    );
  }

  // void changeBrightness() {
  //   DynamicTheme.of(context).setBrightness(
  //       Theme.of(context).brightness == Brightness.dark
  //           ? Brightness.light
  //           : Brightness.dark);
  // }

  // void changePrimaryColor() {
  //   DynamicTheme.of(context).setThemeData(ThemeData(
  //       primaryColor: Theme.of(context).primaryColor == Colors.indigo
  //           ? Colors.red
  //           : Colors.indigo));
  // }

  // void changeAccentColor() {
  //   DynamicTheme.of(context).setThemeData(ThemeData(
  //       accentColor: Theme.of(context).accentColor == Colors.indigo
  //           ? Colors.red
  //           : Colors.indigo));
  // }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: TextFormField(
                      controller: textController,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Text or number for drawing',
                      ))),
              RaisedButton(child: Icon(Icons.add), onPressed: appendTextItem),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RaisedButton(
                child: const Text('Clear list'),
                onPressed: items.isNotEmpty
                    ? () {
                        setState(() {
                          items.clear();
                        });
                      }
                    : null),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     RaisedButton(
          //         color: Theme.of(context).accentColor,
          //         child: const Text('Sort texts'),
          //         onPressed: items.isNotEmpty ? raffle : null),
          //     // const SizedBox(width: 10),
          //     RaisedButton(
          //         child: const Text('Clear list'),
          //         onPressed: items.isNotEmpty
          //             ? () {
          //                 setState(() {
          //                   items.clear();
          //                 });
          //               }
          //             : null),
          //   ],
          // ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.grey,
                height: 1.0,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final String item = items[index];
                return Dismissible(
                  // background: Container(color: Colors.red),
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                  key: Key(item),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  onDismissed: (DismissDirection direction) {
                    removeItem(index);
                  },
                  child: ListTile(
                    title: Text(item),
                    leading: Icon(Icons.label),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void removeItem(int index) {
    final String item = items[index];
    // Remove the item from the data source.
    setState(() {
      itemRemoved = items.removeAt(index);
    });

    // Show a snackbar. This snackbar could also contain "Undo" actions.
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('$item dismissed'),
      action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.yellow,
          onPressed: () {
            setState(() {
              items.insert(index, itemRemoved);
            });
          }),
    ));
  }

  void appendTextItem() {
    if (textController.text.trim() == '') {
      return;
    }

    final List<String> pieces = textController.text.trim().split(',');
    for (int i = 0; i < pieces.length; i++) {
      items.add(pieces[i]);
    }
    setState(() {
      textController.text = '';
    });
  }

  Random random = Random();

  Future<void> raffle() async {
    if (items.isEmpty) {
      return;
    }

    DialogUtils.hideKeyboard(context);
    final int index = random.nextInt(items.length);
    //_showSorted(index);

    final bool removeFromList = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
          builder: (BuildContext context) => RaffleResult(
                valueRaffle: items[index],
              )),
    );
    if (removeFromList != null && removeFromList) {
      removeItem(index);
    }
  }

  Future<void> _saveColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('primaryColor', _tempMainColor.toString());
    await prefs.setString('accentColor', _tempShadeColor.toString());
  }

  Future<void> _openCombosPicker() async {
    _openDialog(
      '2 colors combination',
      TwoColorsPicker(
        selectedColor: TwoColors(
            Theme.of(context).primaryColor, Theme.of(context).accentColor),
        onMainColorChange: (TwoColors colors) => setState(() {
          _tempMainColor = colors.color1;
          _tempShadeColor = colors.color2;
        }),
        circleSize: 40.0,
        spacing: 10,
      ),
    );
  }

  Future<void> _useVerveTheme(String themeName) async {
    final VerveTheme useTheme = VerveTheme.values
        .firstWhere((VerveTheme element) => element.toString() == themeName);
    final ThemeColors themeData = getVerveColors(theme: useTheme);

    _tempMainColor = themeData.main;
    _tempShadeColor = themeData.accent;

    await _saveColors();
    DynamicTheme.of(context).setThemeData(
        ThemeData(primaryColor: _tempMainColor, accentColor: _tempShadeColor));
    setState(() {});
  }

  // void _showSorted(int index) {
  //   final Widget okButton = FlatButton(
  //     child: const Text('OK'),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );

  //   final AlertDialog alerta = AlertDialog(
  //     title: const Text('Sort result'),
  //     content: Text(items[index]),
  //     actions: <Widget>[okButton],
  //   );
  //   showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alerta;
  //     },
  //   );
  // }
}
