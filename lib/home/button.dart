import 'package:flutter/material.dart';
import 'package:xiaoqi/config/size_fit.dart';
import 'dart:ui';

class DraggableFloatingActionButton extends StatefulWidget {
  final Offset initialOffset;
  final VoidCallback onPressed;

  DraggableFloatingActionButton({this.initialOffset, this.onPressed});

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CurvedAnimation curve;
  bool isForward = false;
  bool _isDragging = false;
  Offset _offset;

  @override
  void initState() {
    super.initState();
    final width = window.physicalSize.width / 2;
    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.ease);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      double nowX;
      if (_offset.dx < (width / 2)) {
        nowX = 10;
      } else {
        nowX = (width - 10);
      }
      setState(() {
        _offset = Offset(nowX, _offset.dy);
      });
    });
    _offset = widget.initialOffset;
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;
    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);
          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          isForward ? controller.reverse() : controller.forward();
          isForward = !isForward;
          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        onPointerDown: (PointerDownEvent pointerDownEvent) {
          print('onPointerDown');
        },
        child: Stack(children: [
          Center(
              child: Opacity(
            opacity: 0.4, //设置透明度
            child: Container(
                width: 30.px,
                height: 30.px,
                decoration: new BoxDecoration(
                  //背景Colors.transparent 透明
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(30.px)),
                  //设置四周边框
                )),
          )),
          Positioned(
              left: 2.5.px,
              top: 2.5.px,
              child: Opacity(
                opacity: 0.5, //设置透明度
                child: Container(
                    width: 25.px,
                    height: 25.px,
                    decoration: new BoxDecoration(
                      //背景Colors.transparent 透明
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(25.px)),
                      //设置四周边框
                    )),
              )),
          Positioned(
              left: 5.px,
              top: 5.px,
              child: Opacity(
                opacity: 0.6, //设置透明度
                child: Container(
                    width: 20.px,
                    height: 20.px,
                    decoration: new BoxDecoration(
                      //背景Colors.transparent 透明
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(20.px)),
                      //设置四周边框
                    )),
              ))
        ]),
      ),
    );
  }
}
