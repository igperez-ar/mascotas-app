import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {

  final List<String> words;
  final String hintText;

  const SearchBar({
    Key key,
    @required this.words,
    this.hintText
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  List<String> _words;
  TextEditingController _textEditingController = TextEditingController();

  @override 
  void initState() {
    super.initState();

    _words = widget.words;
  }

  Widget _littleChip(String title) {
    return GestureDetector(
      onTap: () {
        setState(() => _words.remove(title));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 25,
            padding: EdgeInsets.only(left: 10, right: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal[400],
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 3),
                Icon(Icons.close, color: Colors.white, size: 18)
              ]
            )
          )
        ]
      )
    );
  }

  void _processText() {
    String text = _textEditingController.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        _words.add(text);
        _textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            spreadRadius: 1, 
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.search, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _textEditingController,
                  onEditingComplete: _processText,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Buscar...',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              /* IconButton(
                icon: Icon(Icons.add_circle, size: 30),
                onPressed: _processText
              ), */
            ]
          ),
          Visibility(
            visible: _words.isNotEmpty,
            child: Column(
              children: <Widget>[
                Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                  endIndent: 10,
                  height: 0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom:10, top: 10),
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: _words.map<Widget>(
                      (word) => _littleChip(word.trim())
                    ).toList()
                  )
                )
              ],
            )
          )
        ]
      )
    );
  }
}