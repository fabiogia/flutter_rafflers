import 'dart:async';

import 'package:flutter/material.dart';

class RaffleResult extends StatefulWidget {
  const RaffleResult({this.valueRaffle});

  @override
  _RaffleResultState createState() => _RaffleResultState();

  final String valueRaffle;
}

class _RaffleResultState extends State<RaffleResult> {
  double _progressValue = 0;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const Duration threeSec = Duration(milliseconds: 166);
    Timer.periodic(
      threeSec,
      (Timer timer) => setState(
        () {
          _progressValue += 1 / 12;
          if (_progressValue >= 1.0) {
            timer.cancel();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width * 0.6;

    final Widget w = _progressValue < 1.0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Raffling...',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: mediaWidth,
                  height: mediaWidth,
                  child: const CircularProgressIndicator(
                      strokeWidth: 20, value: null // _progressValue,
                      ))
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                const Text(
                  'The raffled value was',
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  widget.valueRaffle,
                  style: const TextStyle(fontSize: 32, color: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: FlatButton(
                    child: const Text('Remove from list'),
                    onPressed: () => Navigator.of(context).pop<bool>(true),
                  ),
                ),
                RaisedButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ]);

    return Scaffold(body: Center(child: w));
  }
}
