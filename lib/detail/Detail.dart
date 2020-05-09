import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/CustomData.dart';

class Detail extends StatefulWidget {

  Detail({Key key, @required this.id, @required this.nm}):super(key: key);
  final int id;
  final String nm;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final Map detailMap = new CustomData().detailMap;

  Map map = {};
  bool flag = false;

  @override
  void initState() {
    getDetail();
  }

  void getDetail() async {
    try {
      Dio dio = new Dio();
      Response response = await dio.get('https://m.maoyan.com/ajax/detailmovie?movieId=${widget.id}');
      // 接口获取不到内容，所以下面代码注释掉，按想法，获取到详情信息后，把图片等响应内容填充到详情页面
      // Map resData = json.decode(response.toString());
      // print('---------------------------------------------------------------');
      // print(response);
      // print('---------------------------------------------------------------');
      // setState(() {
      //   map = resData["detailMovie"];
      //   flag = true;
      // });
    } catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 0, bottom: 30),
        child: Scaffold(
          appBar: AppBar(
            title: Text('${widget.nm}'),
          ),
          body: ListView(
            children: <Widget>[
              Image(
                image: flag == false ? AssetImage('images/loading.gif') : NetworkImage('_imgReset(${map["img"]})'),
                width: 225,
                height: 315,
              ),
              _TextItem(title: '名称', info: '${detailMap["nm"]}'),
              _TextItem(title: '年代', info: '${detailMap["year"]}'),
              _TextItem(title: '产地', info: '${detailMap["src"]}'),
              _TextItem(title: '类别', info: '${detailMap["cat"]}'),
              _TextItem(title: '语言', info: '${detailMap["language"]}'),
              _TextItem(title: '上映日期', info: '${detailMap["comingTitle"]}'),
              _TextItem(title: '豆瓣评分', info: '${detailMap["sc"]}'),
              _TextItem(title: '片长', info: '${detailMap["howLong"]}'),
              _TextItem(title: '导演', info: '${detailMap["director"]}'),
              _TextItem(title: '主演', info: '${detailMap["star"]}', alingFlag: true),
              _TextItem(title: '简介', info: '${detailMap["dra"]}', alingFlag: true),
              Padding(padding: EdgeInsets.only(bottom: 20))
            ],
          ),
          // body: Column(
          //   children: <Widget>[

          //   ],
          // ),
        ));
  }

  String _imgReset(img) {
    // 这里可以处理图片
    return img.replaceAll('/w.h/', '/128.180/');
  }
}

class _TextItem extends StatelessWidget {
  _TextItem({Key key, @required this.title, @required this.info, this.alingFlag})
      : super(key: key);
  final String title;
  final String info;
  final bool alingFlag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: Row(
        crossAxisAlignment: alingFlag == true ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 85,
            child: title.length == 2 ? Text('◎ ${title[0]}        ${title[1]}') : Text('◎ $title'),
          ),
          Expanded(child: Text('$info'))
        ],
      ),
    );
  }
}
