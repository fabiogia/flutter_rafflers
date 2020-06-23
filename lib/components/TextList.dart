import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sorteador_textos/components/RaffleResult.dart';
import 'package:sorteador_textos/utils/DialogUtils.dart';

class TextList extends StatefulWidget {
  _TextListState state;
  @override
  _TextListState createState() {
    state = _TextListState();
    return state;
  }

  void raffle() {
    state.raffle();
  }
}

class _TextListState extends State<TextList> {
  final TextEditingController textController = TextEditingController();

  final List<String> items = <String>[];
  // List<String>.generate(20, (int i) => 'Item ${i + 1}');

  String itemRemoved = '';

  @override
  Widget build(BuildContext context) {
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
                  child: ListTile(title: Text(item)),
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
    Scaffold.of(context).showSnackBar(SnackBar(
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
    final List<String> pieces = textController.text.split(',');
    for (int i = 0; i < pieces.length; i++) {
      items.add(pieces[i]);
    }
    setState(() {
      textController.text = '';
    });
  }

  Random random = Random();

  Future<void> raffle() async {
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
