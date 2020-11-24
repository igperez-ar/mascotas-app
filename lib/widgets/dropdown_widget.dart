import 'package:flutter/material.dart';


class DropdownWidget extends StatefulWidget {
  final _DropdownWidgetState state = _DropdownWidgetState();
  final dynamic items;

  dynamic get selected => state.selected;

  DropdownWidget({
    Key key, 
    @required this.items,
  }): super(key: key);

  @override
  _DropdownWidgetState createState() {
    return this.state;
  }
}

class _DropdownWidgetState extends State<DropdownWidget> with TickerProviderStateMixin {
  bool open = false;
  dynamic selected;
  

  Widget _checkBox(item, bool checked) {

    return GestureDetector(
      onTap: () {
        if (!checked) {
          setState(() {
            selected = item;
            open = false;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 5),
        child: Row(
          children: <Widget>[
            Container(
              width: 25,
              height: 25,
              margin: EdgeInsets.only(right: 10),
              decoration: ( checked 
                ? BoxDecoration( 
                    color: Colors.red[300],
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 1, 
                        offset: Offset(1, 1),
                      )
                    ],
                  ) 
                : BoxDecoration( 
                    border: Border.all(color: Colors.grey[300]),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ) 
              ),
            ),
            Expanded(
              child: Text(
                item.toString(),
                overflow: TextOverflow.clip,
              )
            )
          ],
        )
      )
    );  
  }

  Widget _chip(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.red[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1, 
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      )
    );
  }

  void _changeOpen() {
    setState(() {
      open = !open;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Colors.grey[400], width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            width: _width,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Row(children: <Widget>[
                  Expanded(
                    child: (selected == null ? 
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text("Selecciona una opción.", 
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        )
                      ) :
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [_chip(selected.toString())],
                        )
                      )
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 40,
                        color: Colors.grey,
                      ),
                      onPressed: _changeOpen
                    ),
                  )
                ],
              )
            ),
          ),
          AnimatedSize(
            vsync: this,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 200),
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              constraints: ( open 
                ? BoxConstraints(maxHeight: double.infinity)
                : BoxConstraints(maxHeight: 0.0)
              ),
              child: Column(
                children: widget.items.map<Widget>(
                  (item) => _checkBox(item, selected == item)
                ).toList()
              )
            )
          )
        ]
      )
    );
  }
}