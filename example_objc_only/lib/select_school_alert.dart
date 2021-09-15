import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_faraday/g_faraday.dart';

import '../settle_school_item.dart';

class SelectSchoolAlert extends StatelessWidget {
  final List alertList = [
    {"title": "1、高端峰会优先邀请", "subtitle": "高端峰会，企业版的用户"},
    {"title": "2、干货课程限量开放", "subtitle": "与行业知名专家联合制作，限量开放给企业版的用户"},
    {"title": "3、核心数据实时查询", "subtitle": "核心数据可实时查询"},
    {"title": "4、支持移动端快速审批", "subtitle": "集成了企业版审批功能，让管理者随时随地审批"}
  ];

  late List<SettleSchoolItem> _alertItems;

  List<SettleSchoolItem> get _listViews {
    if (_alertItems == null) {
      _alertItems = [];
      for (Map alertMap in alertList) {
        _alertItems.add(SettleSchoolItem(alertMap["title"], alertMap["subtitle"]));
      }
    }
    return _alertItems;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FaradayNotificationListener(
          ["推送测试"],
          onNotification: (context, value) {
            debugPrint("收到通知：${value.toString()}");
          },
          child: Container(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectSchoolAlert()));
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              color: Colors.green,
                              padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                              alignment: Alignment.center,
                              child: Text(
                                "尊敬的用户",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "入驻企业版后您将获得以下特权",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                            child: Column(
                              children: _listViews,
                            ),
                          ),
                          // Expanded(
                          //   child: ListView.builder(
                          //       padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                          //       itemBuilder: (BuildContext context, int index) {
                          //         Map alertMap = alertList[index];
                          //         return SettleSchoolItem(alertMap["title"], alertMap["subtitle"]);
                          //       },
                          //       itemCount: alertList.length),
                          // ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                            height: 69,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      debugPrint("点击跳过");
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      side: MaterialStateProperty.all(BorderSide(color: Color(0x1A000000), width: 1)),
                                    ),
                                    child: Container(
                                      child: Text("跳过", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () {
                                        debugPrint("测试");
                                        //Navigator.of(context).pop();
                                        //FlutterCore.invokeNative("http://flutter.xxxx.cn/test/alert");
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                                      ),
                                      child: Container(
                                        child: Text("立即入驻", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
