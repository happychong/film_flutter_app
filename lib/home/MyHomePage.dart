import 'package:flutter/material.dart';

import './HomeBody.dart';
import '../movie/MovieList.dart';
import '../cinema/CinemaList.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // DefaultTabController - 导航与页面的联动效果控制器组件
    return DefaultTabController(
      // 控制器-控制页面切换的数量，这个数量是页面和导航的数量，二者要一致
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // title: Text(widget.title),
          title: Text('我的影院'),
          centerTitle: true,
          actions: <Widget>[
            // 右侧搜索按钮
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        // drawer 侧边栏
        drawer: Drawer(
          // 从上到下排列的盒子容器，也可以从左往右排列
          child: ListView(
            // 去掉padding间距
            padding: EdgeInsets.all(0),
            // <Widget> 规定
            children: <Widget>[
              // 侧边栏头部
              UserAccountsDrawerHeader(
                accountName: Text('心_语'),
                accountEmail: Text('349739@qq.com'),
                // 头像区域
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588827223202&di=245ee53c9ce5cce1cacd2740e1356ca2&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D3571592872%2C3353494284%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1200%26h%3D1290'),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588826971731&di=669ec6bdc5763555495d24b35595a531&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D1307125826%2C3433407105%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D5760%26h%3D3240'),
                  fit: BoxFit.cover,
                )),
              ),
              ListTile(title: Text('我的发布'), trailing: Icon(Icons.send)),
              ListTile(title: Text('我的收藏'), trailing: Icon(Icons.feedback)),
              ListTile(title: Text('系统设置'), trailing: Icon(Icons.settings)),
              // Divider 线
              // Colors.fromARGB(a, r, g, b) - 自定义颜色 a - 255 透明度  但是这个版本没试验成功
              Divider(color: Colors.black54),
              ListTile(title: Text('注销'), trailing: Icon(Icons.exit_to_app)),
            ],
          ),
        ),
        // 页面需要传递 TabBarView ，来实现联动效果，与底部导航的TabBar对应
        body: TabBarView(
          children: <Widget>[
            // 30 - 单位是固定值，如果想适配，了解 flutter_screenutil 插件  
            HomeBody(),
            MovieList(),
            CinemaList(),
          ],
        ),
        // 底部导航
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.black),
          // TabBar - 系统提供的底部导航组件，可以实现与页面的联动
          child: TabBar(
            labelStyle: TextStyle(
              // 字符高度
              height: 0,
              fontSize: 11,
            ),
            tabs: <Widget>[
              Tab(text: '首页', icon: Icon(Icons.home)),
              Tab(text: '正在热映', icon: Icon(Icons.movie_creation)),
              Tab(text: '影院信息', icon: Icon(Icons.local_movies))
            ],
          ),
        ),
      ),
    );
  }
}
