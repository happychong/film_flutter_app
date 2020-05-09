import 'package:flutter/material.dart';
import '../data/CustomData.dart';

class MovieScroll extends StatelessWidget {
  // flutter 中，一切皆组件啊，每一个组件都是一个类，类的调用需要用 new ，但是也可以省略
  final List scrolllist = new CustomData().scrolllist;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      // 数组长度不固定的时候，用ListView.builder
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: scrolllist.length, // 数组遍历的次数
        itemBuilder: (BuildContext context, int index) {
          return ScrollItem(item: scrolllist[index]);
        },
      ),
    );
  }
}

class ScrollItem extends StatelessWidget {
  ScrollItem({Key key, @required this.item}) : super(key: key);
  final Map item;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 127.5,
      padding: EdgeInsets.only(left: 5, right:5),
      child: Column(
        children: <Widget>[
          // 图片
          Container(
            width: 127.5,
            child: Image(
              height: 178.5,
              image: NetworkImage('${item["img"]}'),
              fit: BoxFit.cover,
            )
          ),
          // 标题
          Text('${item["name"]}'),
          // 描述信息
          Text(
            '${item["dra"]}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
