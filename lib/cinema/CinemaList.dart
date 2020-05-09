import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class CinemaList extends StatefulWidget {
  @override
  _CinemaListState createState() => _CinemaListState();
}

class _CinemaListState extends State<CinemaList> {
  List cinemas = [];

  Color color0 = Color.fromARGB(255, 240, 61, 55); // 红色
  Color color1 = Color.fromARGB(255, 255, 153, 0); // 橙色
  Color color2 = Color.fromARGB(255, 88, 157, 175); // 黄绿色

  List<Widget> tagList = [];

  List tagWidgets(types) {
    // tag标签的数组
    //   _CinemaTag(color: color1, tag: '小吃'),
    //   _CinemaTag(color: color1, tag: '爆米花'),
    //   _CinemaTag(color: color2, tag: '杜比全景声厅'),
    tagList = [];
    if (types["is_free"] == 1) {
      tagList.add(_CinemaTag(color: color2, tag: '免费'));
    }
    if (types["has_rc"] == 1) {
      tagList.add(_CinemaTag(color: color2, tag: '改签'));
    }
    if (types["isplay"] == 1) {
      tagList.add(_CinemaTag(color: color1, tag: '小吃'));
    }
    if (types["search_num"] is String &&
        types["rating"].length > 0 &&
        int.parse(types["rating"]) > 95) {
      tagList.add(_CinemaTag(color: color0, tag: '热'));
    }
    if (types["type"] is List) {
      types["type"].forEach((item) {
        tagList.add(_CinemaTag(color: color1, tag: '${item["name"]}'));
      });
    }
    return tagList;
  }

  @override
  void initState() {
    getCinemaList();
    super.initState();
  }

  void getCinemaList() async {
    try {
      Dio dio = new Dio();
      Response response = await dio.get(
          'http://v.baidu.com/commonapi/movie2level/?filter=false&type=&area=&actor=&start=&complete=&order=rating&pn=1&rating=&prop=&channel=movie');
      Map resData = jsonDecode(response.toString());
      setState(() {
        cinemas = resData["videoshow"]["videos"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: cinemas.length,
        itemBuilder: (BuildContext context, int i) {
          Map _cinema = cinemas[i];
          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                // 标题 + 年份
                Padding(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${_cinema["title"]}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                        ' ${_cinema["date"]}',
                        style: TextStyle(
                          color: color0,
                          fontSize: 18,
                        ),
                      ),
                      Text('年',
                          style: TextStyle(
                            color: color0,
                            fontSize: 11,
                          ))
                    ],
                  ),
                  padding: EdgeInsets.only(bottom: 3),
                ),
                // 地址 + 距离
                Padding(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${_cinema["intro"]}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 102, 102, 102)),
                        ),
                      ),
                      Text(
                        '${_getKm(_cinema["id"])}km',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 102, 102, 102)),
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(bottom: 3),
                ), // tap标签
                // tap
                Padding(
                  child: Row(
                    // children: <Widget>[
                    //   _CinemaTag(color: color1, tag: '小吃'),
                    //   _CinemaTag(color: color1, tag: '爆米花'),
                    //   _CinemaTag(color: color2, tag: '杜比全景声厅'),
                    // ],
                    children: tagWidgets(_cinema),
                  ),
                  padding: EdgeInsets.only(bottom: 5),
                ),
                // icon + 优惠信息
                _getExdTd(_cinema["extRd"]).length > 4
                    ? Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/icon.jpg'),
                            width: 17,
                            height: 17,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              '${_getExdTd(_cinema["extRd"])}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  _getKm(val) {
    return int.parse(val) / 1000;
  }

  String _getExdTd(extRd) {
    String str;
    // return '无';
    if (extRd is List) {
      if (extRd[0] is Map) {
        if (extRd[0]["name"] is String) {
          str = extRd[0]["name"];
        } else {
          str = "无优惠";
        }
      } else {
        str = "无优惠";
      }
    } else {
      str = "无优惠";
    }
    return str;
  }
}

class _CinemaTag extends StatelessWidget {
  _CinemaTag({Key key, @required this.tag, @required this.color})
      : super(key: key);
  final String tag;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      padding: EdgeInsets.fromLTRB(3, 0, 3, 1),
      margin: EdgeInsets.only(right: 5),
      child: Text(
        '$tag',
        style: TextStyle(
          color: color,
          fontSize: 10,
        ),
      ),
    );
  }
}
