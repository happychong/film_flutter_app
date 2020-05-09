import 'dart:convert';

import 'package:flutter/material.dart';
// import '../data/CustomData.dart';
import 'package:dio/dio.dart';

import '../detail/Detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  // 这里是应用假数据的方式，注释掉
  // final List list = new CustomData().list;
  List list = [];

  @override
  void initState() {
    getMovieList();
    super.initState();
  }

  getMovieList() async {
    try {
      Dio dio = Dio();
      // Response response = await dio.get(
      //     'https://haokan.baidu.com/videoui/api/videorec?tab=yinyue&act=pcFeed&pd=pc&num=5&shuaxin_id=1588753929916&hot=1');
      Response response = await dio.get(
          'https://m.maoyan.com/ajax/mostExpected?ci=1&limit=10&offset=0&token=&optimus_uuid=ABD935108F3C11EA97A8EDD15B2B01D03F63A8B78C9A4E5889A7AFC4517244CF&optimus_risk_level=71&optimus_code=10');
      // print('------------------');
      // print(response);
      // print('------------------');
      Map resData = jsonDecode(response.toString());
      setState(() {
        // list = resData["data"]["response"]["videos"];
        list = resData["coming"];
      });
      // print('-------------------------------');
      // print('${resData["data"]["response"]["videos"][0]}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i) {
        final Map _myItem = list[i];
        return GestureDetector(
          onTap: () {
            // 跳转到详情页
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return Detail(id: _myItem["id"], nm: _myItem["nm"]);
              },
            ));
          },
          child: Container(
            // EdgeInsets.all(10) : 四个方向都是10
            // EdgeInsets.fromLTRB(left, top, right, bottom)
            // EdgeInsets.only(left: 10, top: 10)
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image(
                  // image: NetworkImage('${_myItem["img"]}'),
                  image: NetworkImage('${_imgReset(_myItem["img"])}'), // _imgReset可以处理图片
                  fit: BoxFit.cover,
                  width: 115,
                  height: 170,
                ),
                // Expanded 弹性盒子容器，可以占据多余空间
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${_myItem["nm"] ?? "无"}',
                          style: TextStyle(fontSize: 17),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '评分:${_myItem["wish"] ?? "无"}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          // ?? 非空判断 类似js中的||
                          '主演:${_myItem["wishst"] ?? "无"}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          '上映日期:${_myItem["comingTitle"] ?? "无"}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '排期:${_myItem["title"] ?? "无"}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String _imgReset(img) {
    // 这里可以处理图片
    return img.replaceAll('/w.h/', '/128.180/');
  }
}
