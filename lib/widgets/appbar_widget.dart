import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {

  final String title;
  final String subtitle;
  final List<Map> actions;

  @override
  final Size preferredSize;

  AppBarWidget({
    Key key,
    this.title,
    this.subtitle,
    this.actions
  }) : preferredSize = Size.fromHeight(150.0), 
       super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.only(left: 30, right: 10, top: 5),
        color: Colors.red[300],
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions.map((item) => IconButton(
                    padding: EdgeInsets.zero,
                    icon: FaIcon(item['icon'], size: 28, color: Colors.white), 
                    onPressed: item['onPressed']
                  ),
                ).toList()
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, 
                      style: TextStyle(
                        color: Colors.grey[50],
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(subtitle, 
                      style: TextStyle(
                        color: Colors.grey[50],
                        fontSize: 28,
                      ),
                    ),
                  ]
                )
              )
            ],
          )
        )
    );
  }
}