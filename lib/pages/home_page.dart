import 'dart:async';
import 'package:data_statistics/db/db_helper.dart';
import 'package:data_statistics/models/baidu_model.dart' as baidu;
import 'package:data_statistics/models/weibo_model.dart' as weibo;
import 'package:data_statistics/models/zhihu_model.dart';
import 'package:data_statistics/pages/news_page/weibo_page.dart';
import 'package:data_statistics/pages/news_page/zhihu_page.dart';
import 'package:data_statistics/request/api.dart';
import 'package:flutter/material.dart';
import 'news_page/baidu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ZHDetailModel> zHDetailModelList = [];
  List<baidu.BDDetailModel> dDDetailModelList = [];
  List<weibo.WBDetailModel> wbDetailModelList = [];

  @override
  void initState() {
    super.initState();

    refresh();

    Timer.periodic(const Duration(minutes: 10), (timer) => refresh());
  }

  void refresh() async {
    print('更新时间:${DateTime.now()}');

    await getZhihuData();
    await getBaiduData();
    await getWeiboData();

    getAllNews();
  }

  getAllNews() async {
    zHDetailModelList = await DbHelper.instance.zhihuTable.query();

    dDDetailModelList = await DbHelper.instance.baiduTable.query();

    wbDetailModelList = await DbHelper.instance.weiboTable.query();

    setState(() {});
  }

  getWeiboData() async {
    List<weibo.CardGroup> wbModelList = await Api.getWeiboNews();
    for (weibo.CardGroup group in wbModelList) {
      weibo.WBDetailModel wbDetailModel = weibo.WBDetailModel(title: group.desc, scheme: group.scheme, itemid: group.itemid, create: DateTime.now().millisecondsSinceEpoch.toStringAsFixed(0));
      await DbHelper.instance.weiboTable.insertHot(wbDetailModel);
    }
  }

  getZhihuData() async {
    List<ZHModel> zhModelList = await Api.getZhihuNews();
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
    List<baidu.Cards>? zhModelList = await Api.getBaiduNews();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: const EdgeInsets.only(top: 20), child: newsWidget()),
    );
  }

  Widget newsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: WeiboPage(
          modelList: wbDetailModelList,
        )),
        Expanded(
            child: ZhihuPage(
          modelList: zHDetailModelList,
        )),
        const SizedBox(width: 10,),
        Expanded(
            child: BaiduPage(
          modelList: dDDetailModelList,
        )),
      ],
    );
  }
}
