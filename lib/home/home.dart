import 'package:flutter/material.dart';
import 'package:xiaoqi/config/size_fit.dart';
import 'package:xiaoqi/home/button.dart';
import 'package:ussd_service/ussd_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> functionModule = [
    "点击拨打"
    //  "日志","收支", "速记", "搭配", "物料"
  ];
  bool phoneTag = false;
  String message = "没有拨打电话";
  makeMyRequest() async {
    int subscriptionId = 1; // sim card subscription ID
    String code = "15336970181"; // ussd code payload
    try {
      print("calling");
      String ussdResponseMessage = await UssdService.makeRequest(
        subscriptionId,
        code,
        Duration(seconds: 5), // timeout (optional) - default is 10 seconds
      );
      print("succes! message: $ussdResponseMessage");
      setState(() {
        message = ussdResponseMessage;
      });
    } catch (e) {
      debugPrint("error! code: ${e.code} - message: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Center(
            child: ListView(
                children: functionModule.map((module) {
              return Container(
                margin: EdgeInsets.all(10.0),
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Center(
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blue)),
                      child: Text(phoneTag ? "正在拨打" : module,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        print("call");
                        setState(() {
                          phoneTag = true;
                          message = "正在拨打电话";
                        });
                        makeMyRequest();
                        print("call-down");
                      }),
                  //     Text(
                  //   module,
                  //   style: TextStyle(color: Colors.white),
                  // )
                ),
              );
            }).toList()),
          ),
          DraggableFloatingActionButton(
            initialOffset: Offset(10.px, 20.px),
            onPressed: () {},
          )
        ]));
  }
}
