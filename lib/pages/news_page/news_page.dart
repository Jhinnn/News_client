import 'package:data_statistics/pages/news_page/baidu_page.dart';
import 'package:data_statistics/pages/news_page/weibo_page.dart';
import 'package:data_statistics/pages/news_page/zhihu_page.dart';
import 'package:flutter/material.dart';
import 'package:data_statistics/models/baidu_model.dart' as baidu;
import 'package:data_statistics/models/weibo_model.dart' as weibo;
import 'package:data_statistics/models/zhihu_model.dart';

class HeaderItemBean {
  final String labelTitle;
  HeaderItemBean(this.labelTitle);
}

final List<HeaderItemBean> _allPages = <HeaderItemBean>[
  HeaderItemBean("百度"),
  HeaderItemBean("知乎"),
  HeaderItemBean("微博"),
];

class NewsPage extends StatefulWidget {
  final List<ZHDetailModel> zHDetailModelList;
  final List<baidu.BDDetailModel> dDDetailModelList;
  final List<weibo.WBDetailModel> wbDetailModelList;
  const NewsPage(
      {Key? key,
      required this.zHDetailModelList,
      required this.dDDetailModelList,
      required this.wbDetailModelList})
      : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    Widget titleLayout = TabBar(
      isScrollable: true,
      labelPadding: const EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      indicatorColor: Colors.white,
      tabs: _allPages
          .map((HeaderItemBean page) => Tab(text: page.labelTitle))
          .toList(),
    );

    return DefaultTabController(
        length: _allPages.length,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: titleLayout,
          ),
          body: TabBarView(children: [
            BaiduPage(
              modelList: widget.dDDetailModelList,
            ),
            ZhihuPage(
              modelList: widget.zHDetailModelList,
            ),
            WeiboPage(
              modelList: widget.wbDetailModelList,
            ),
          ]),
        ));
  }
}
