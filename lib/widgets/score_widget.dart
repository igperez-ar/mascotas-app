import 'package:flutter/material.dart';


class ScoreWidget extends StatefulWidget {

  final int selected;
  final Function(int) onPress;

  const ScoreWidget({
    Key key,
    this.onPress,
    this.selected,
  }) : super(key: key);

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  int selected;

  @override
  void initState() {
    super.initState();

    if (widget.selected != null)
      setState(() {
        selected = widget.selected;
      });
  }

  List<Widget> _getIcons() {
    List<Widget> _children = [];

    for (var value = 1; value <= 5; value++) {

      _children.add(
        IconButton(
          padding: EdgeInsets.zero,
          iconSize: 60,
          onPressed: () {
            setState(() {
              this.selected = value;
            });
            if (widget.onPress != null)
              widget.onPress(value);
          },
          icon: Icon(
            this.selected != null && this.selected >= value ? Icons.star : Icons.star_border,
            color: this.selected != null && this.selected >= value ? Colors.red[300] : Colors.grey,
            size:  this.selected != null && this.selected >= value ? 45 : 40,
          ),
        )
      );
    }

    return _children;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getIcons()
    );
  }
}