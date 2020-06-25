import 'package:flutter/material.dart';

class TwoCircleColor extends StatelessWidget {
  const TwoCircleColor({
    Key key,
    @required this.color1,
    @required this.color2,
    @required this.circleSize,
    this.onColorChoose,
    this.isSelected = false,
    this.elevation = _kColorElevation,
    this.iconSelected,
  })  : assert(color1 != null, 'You must provide a not null Color'),
        assert(circleSize != null, 'CircleColor must have a not null size'),
        assert(circleSize >= 0, 'You must provide a positive size'),
        assert(!isSelected || (isSelected && iconSelected != null)),
        super(key: key);

  static const double _kColorElevation = 4.0;

  final bool isSelected;
  final Color color1;
  final Color color2;
  final VoidCallback onColorChoose;
  final double circleSize;
  final double elevation;
  final IconData iconSelected;

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(color1);
    final Color icon =
        brightness == Brightness.light ? Colors.black : Colors.white;

    return GestureDetector(
        onTap: onColorChoose,
        child: Container(
          width: circleSize,
          height: circleSize / 2,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: CircleAvatar(
                  radius: circleSize / 2,
                  backgroundColor: color1,
                  child: null,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  radius: circleSize / 2,
                  backgroundColor: color2,
                  child: isSelected ? Icon(iconSelected, color: icon) : null,
                ),
              )
            ],
          ),
        )

        // CircleAvatar(
        //   radius: circleSize / 2,
        //   backgroundColor: color,
        //   child: isSelected ? Icon(iconSelected, color: icon) : null,
        // ),

        );
  }
}
