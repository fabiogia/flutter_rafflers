import 'package:flutter/material.dart';
import 'package:sorteador_textos/components/two_colors_picker/two_circle_color.dart';
import 'package:sorteador_textos/components/two_colors_picker/colors.dart';

class TwoColorsPicker extends StatefulWidget {
  TwoColorsPicker({
    Key key,
    this.selectedColor,
    this.onColorChange,
    this.onMainColorChange,
    this.colors,
    this.shrinkWrap = false,
    this.physics,
    this.iconSelected = Icons.check,
    this.circleSize = 45.0,
    this.spacing = 9.0,
    this.onBack,
    this.elevation,
  }) : super(key: key);

  final TwoColors selectedColor;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<TwoColors> onMainColorChange;
  final List<TwoColors> colors;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final double circleSize;
  final double spacing;
  final IconData iconSelected;
  final VoidCallback onBack;
  final double elevation;

  @override
  _TwoColorsPickerState createState() => _TwoColorsPickerState();
}

class _TwoColorsPickerState extends State<TwoColorsPicker> {
  final _defaultValue = comboColors[0];

  List<TwoColors> _colors = comboColors;

  TwoColors _mainColor;

  @override
  void initState() {
    super.initState();
    _initSelectedValue();
  }

  @protected
  void didUpdateWidget(covariant TwoColorsPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initSelectedValue();
  }

  void _initSelectedValue() {
    if (widget.colors == null) {
      _colors = comboColors;
    } else {
      _colors = widget.colors;
    }

    TwoColors mainColor = widget.selectedColor ?? _defaultValue;

    mainColor ??= _colors[0];

    setState(() {
      _mainColor = mainColor;
    });
  }

  void _onMainColorSelected(TwoColors color) {
    setState(() {
      _mainColor = color;
    });
    if (widget.onMainColorChange != null) {
      widget.onMainColorChange(color);
    }
  }

  List<Widget> _buildListMainColor(List<TwoColors> colors) {
    return [
      for (final color in colors)
        TwoCircleColor(
          color1: color.color1,
          color2: color.color2,
          circleSize: widget.circleSize,
          onColorChoose: () => _onMainColorSelected(color),
          isSelected: _mainColor == color,
          iconSelected: widget.iconSelected,
          elevation: widget.elevation,
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final listChildren = _buildListMainColor(_colors);

    // Size of dialog
    final double width = MediaQuery.of(context).size.width * .80;
    // Number of circle per line, depend on width and circleSize
    final int nbrCircleLine =
        width ~/ ((widget.circleSize * 2) + widget.spacing);

    return Container(
      width: width,
      child: GridView.count(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: widget.spacing,
        mainAxisSpacing: widget.spacing,
        crossAxisCount: nbrCircleLine,
        children: listChildren,
      ),
    );
  }
}
