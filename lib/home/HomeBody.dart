import 'package:flutter/material.dart';
import './MovieScroll.dart';

// 这里搞纯净太，假数据
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HomeBodyArea(title: '最新电影'),
        HomeBodyArea(title: '最新电视剧'),
        HomeBodyArea(title: '最新动漫'),
        HomeBodyArea(title: '最新综艺'),
      ],
    );
  }
}

class HomeBodyArea extends StatelessWidget {
  HomeBodyArea({Key key, @required this.title}):super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      // Column 总想排列组件，Row横向排列组件
      child: Column(
        // 排列
        // mainAxisAlignment  // 主轴
        // crossAxisAlignment // 副轴 or 交叉轴
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 18,
                    // 行高
                  ),
                ),
                Text(
                  '更多>>',
                  style: TextStyle(
                    color: Colors.blue,
                    height: 1.3
                  ),
                )
              ],
            ),
          ),
          MovieScroll()
        ],
      ),
    );
  }
}
