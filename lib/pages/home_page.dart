import 'dart:async';
import 'dart:io';

import 'package:data_statistics/db/db_helper.dart';
import 'package:data_statistics/models/baidu_model.dart' as baidu;
import 'package:data_statistics/models/weibo_model.dart' as weibo;
import 'package:data_statistics/models/zhihu_model.dart';
import 'package:data_statistics/pages/news_page/news_page.dart';
import 'package:data_statistics/pages/news_page/weibo_page.dart';
import 'package:data_statistics/pages/news_page/zhihu_page.dart';
import 'package:data_statistics/pages/setting_page.dart';
import 'package:data_statistics/request/api.dart';
import 'package:flutter/material.dart';

import 'news_page/baidu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ZHDetailModel> zHDetailModelList = [];
  List<baidu.BDDetailModel> dDDetailModelList = [];
  List<weibo.WBDetailModel> wbDetailModelList = [];

  late Timer _timer;
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState

    getAllData();

    _timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      getAllData();
    });
  }

  getAllData() async {
    print('更新时间:${DateTime.now()}');
    await getZhihuData();
    await getBaiduData();
    await getWeiboData();
    queryAllData();
  }

  queryAllData() async {
    zHDetailModelList = await DbHelper.instance.zhihuTable.query();

    dDDetailModelList = await DbHelper.instance.baiduTable.query();

    wbDetailModelList = await DbHelper.instance.weiboTable.query();

    setState(() {});
  }

  getWeiboData() async {
    List<weibo.CardGroup> wbModelList = await Api.fetchWeiboPackages();
    for (weibo.CardGroup group in wbModelList) {
      weibo.WBDetailModel wbDetailModel = weibo.WBDetailModel(
          title: group.desc,
          scheme: group.scheme,
          itemid: group.itemid,
          create: DateTime.now().millisecondsSinceEpoch.toStringAsFixed(0));
      await DbHelper.instance.weiboTable.insertHot(wbDetailModel);
    }
  }

  getZhihuData() async {
    List<ZHModel> zhModelList = await Api.fetchZhihuPackages();
    for (ZHModel zhModel in zhModelList) {
      ZHDetailModel zhDetailModel = ZHDetailModel(
          id: zhModel.target!.id!,
          title: zhModel.target!.title!,
          url: zhModel.target!.url!,
          type: zhModel.target!.type!,
          created: zhModel.target!.created!.toString(),
          excerpt: zhModel.target!.excerpt!,
          thumbnail: zhModel.children!.first.thumbnail);
      await DbHelper.instance.zhihuTable.insertHot(zhDetailModel);
    }
  }

  getBaiduData() async {
    List<baidu.Cards>? zhModelList = await Api.fetchBaidu();
    List<baidu.Content>? listContent = zhModelList!.first.content;
    for (baidu.Content content in listContent!) {
      baidu.BDDetailModel bdDetailModel = baidu.BDDetailModel(
          appUrl: content.appUrl!,
          desc: content.desc!,
          hotScore: content.hotScore!,
          query: content.query!,
          rawUrl: content.rawUrl!,
          img: content.img,
          url: content.url!,
          word: content.word!,
          updateTime: zhModelList.first.updateTime.toString());
      await DbHelper.instance.baiduTable.insertHot(bdDetailModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS || Platform.isAndroid
        ? Scaffold(
            backgroundColor: Colors.black,
            bottomNavigationBar: BottomNavigationBar(
                onTap: (i) {
                  setState(() {
                    index = i;
                  });
                },
                currentIndex: index,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.newspaper,
                    ),
                    activeIcon: Icon(
                      Icons.newspaper,
                    ),
                    label: '新闻',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.photo,
                    ),
                    activeIcon: Icon(
                      Icons.photo,
                    ),
                    label: '相册',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    activeIcon: Icon(
                      Icons.search,
                    ),
                    label: '22',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    activeIcon: Icon(
                      Icons.settings,
                    ),
                    label: '设置',
                  ),
                ]),
            body: IndexedStack(
              index: index,
              children: [
                NewsPage(
                    zHDetailModelList: zHDetailModelList,
                    dDDetailModelList: dDDetailModelList,
                    wbDetailModelList: wbDetailModelList),
                const SettingPage(),
                const SettingPage(),
                const SettingPage(),
              ],
            ))
        : Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(top: 20), child: pcWidget()),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  getAllData();
                },
                child: const Icon(Icons.refresh)));
  }

  pcWidget() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: WeiboPage(
              modelList: wbDetailModelList,
            )),
        Expanded(
            flex: 1,
            child: ZhihuPage(
              modelList: zHDetailModelList,
            )),
        Expanded(
            flex: 1,
            child: BaiduPage(
              modelList: dDDetailModelList,
            )),
      ],
    );
  }
}
