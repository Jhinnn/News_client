import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_statistics/models/baidu_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

class BaiduPage extends StatelessWidget {
  final List<BDDetailModel> modelList;
  const BaiduPage({Key? key, required this.modelList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid || Platform.isIOS
        ? mobileWidget(context)
        : pcWidget();
  }

  mobileWidget(BuildContext context) {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (context, index) {
        BDDetailModel element = modelList[index];
        return InkWell(
            onTap: () {
              String urlString = element.rawUrl.replaceFirstMapped(
                  'm.baidu.com', (match) => 'www.baidu.com');
              Uri url = Uri.parse(urlString);
              launchUrl(url);
            },
            child: style1(element, context));
      },
    );
  }

  style2(BDDetailModel element, BuildContext context) {
    String timeTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(element.updateTime) * 1000,
    ).toString().substring(0, 16);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 0.618,
                  child: CachedNetworkImage(
                    imageUrl: element.img!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.8),
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 10),
                        child: Text(
                          element.word,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              width: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  element.desc,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    timeTime,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }

  style1(BDDetailModel element, BuildContext context) {
    String timeTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(element.updateTime) * 1000,
    ).toString().substring(0, 16);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: element.img!,
              width: 110,
              height: 110 * 0.618,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    element.word,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    element.desc,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        Text(
          timeTime,
          style: Theme.of(context).textTheme.overline,
        ),
      ]),
    );
  }

  pcWidget() {
    return GroupedListView<BDDetailModel, String>(
      elements: modelList,
      groupBy: (element) {
        String timeTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(element.updateTime) * 1000,
        ).toString();
        return timeTime.substring(0, 10);
      },
      groupSeparatorBuilder: (String groupByValue) {
        return Image.asset(
          'assets/images/baidu.png',
          width: 120,
          height: 50,
        );
      },
      itemBuilder: (context, BDDetailModel element) {
        String timeTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(element.updateTime) * 1000,
        ).toString().substring(0, 16);
        return InkWell(
          onTap: () {
            String urlString = element.rawUrl
                .replaceFirstMapped('m.baidu.com', (match) => 'www.baidu.com');
            Uri url = Uri.parse(urlString);
            launchUrl(url);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: element.img!,
                    width: 80,
                    height: 80 * 0.618,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 80 * 0.618,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            element.word,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            timeTime,
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Text(
                element.desc,
                maxLines: 5,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ]),
          ),
        );
      },
      itemComparator: (item1, item2) =>
          item1.updateTime.compareTo(item2.updateTime),
      useStickyGroupSeparators: false,
      floatingHeader: false,
      order: GroupedListOrder.DESC,
    );
  }
}
