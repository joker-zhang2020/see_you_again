import 'package:flutter/material.dart';
import 'package:xiaoqi/config/size_fit.dart';

class CircleNavigationBar extends StatefulWidget {
  const CircleNavigationBar({Key key}) : super(key: key);

  @override
  _CircleNavigationBarState createState() => _CircleNavigationBarState();
}

class _CircleNavigationBarState extends State<CircleNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 182.5.px,
        height: 182.5.px,
        child: Stack(alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
            children: <Widget>[
              Positioned(
                  bottom: -182.5.px,
                  child: Container(
                    width: 365.px,
                    height: 365.px,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(182.5.px)),
                      border: Border.all(width: 0, style: BorderStyle.none),
                    ),
                  ))
            ]));
  }
}
