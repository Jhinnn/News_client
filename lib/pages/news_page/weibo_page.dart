import 'dart:io';

import 'package:data_statistics/models/weibo_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

class WeiboPage extends StatelessWidget {
  final List<WBDetailModel> modelList;
  const WeiboPage({Key? key, required this.modelList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid || Platform.isIOS ? mobileWidget() : pcWidget();
  }

  mobileWidget() {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (context, index) {
        WBDetailModel element = modelList[index];
        return InkWell(
          onTap: () {
            String urlString =
                'https://s.weibo.com/weibo?q=%23${element.title}%23';
            Uri url = Uri.parse(urlString);
            launchUrl(url);
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              element.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        );
      },
    );
  }

  pcWidget() {
    return GroupedListView<WBDetailModel, String>(
      elements: modelList,
      groupBy: (element) {
        String timeTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(element.create),
        ).toString();
        return timeTime.substring(0, 10);
      },
      groupSeparatorBuilder: (String groupByValue) {
        return Image.asset(
          'assets/images/weibo.png',
          width: 120,
          height: 50,
        );
      },
      itemBuilder: (context, WBDetailModel element) {
        return InkWell(
          onTap: () {
            String urlString =
                'https://s.weibo.com/weibo?q=%23${element.title}%23';
            Uri url = Uri.parse(urlString);
            launchUrl(url);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(element.title,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        );
      },
      itemComparator: (item1, item2) => item1.create.compareTo(item2.create),
      useStickyGroupSeparators: false,
      floatingHeader: false,
      order: GroupedListOrder.DESC,
    );
  }
}
