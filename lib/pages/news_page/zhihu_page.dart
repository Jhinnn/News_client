import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_statistics/models/zhihu_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ZhihuPage extends StatelessWidget {
  final List<ZHDetailModel> modelList;
  const ZhihuPage({Key? key, required this.modelList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid || Platform.isIOS
        ? mobileWidget(context)
        : pcWidget();
  }

  pcWidget() {
    return GroupedListView<ZHDetailModel, String>(
      elements: modelList,
      groupBy: (element) {
        String timeTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(element.created) * 1000,
        ).toString();
        return timeTime.substring(0, 10);
      },
      groupSeparatorBuilder: (String groupByValue) {
        return Image.asset(
          'assets/images/zhihu.png',
          width: 120,
          height: 50,
        );
      },
      itemBuilder: (context, ZHDetailModel element) {
        String timeTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(element.created) * 1000,
        ).toString().substring(0, 16);
        return InkWell(
            onTap: () {
              Uri url;
              if (element.type == 'question') {
                url = Uri.parse('https://www.zhihu.com/question/${element.id}');
              } else {
                url = Uri.parse('https://zhuanlan.zhihu.com/p/${element.id}');
              }
              launchUrl(url);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: element.thumbnail!,
                          width: 80,
                          height: 80 * 0.618,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const FlutterLogo();
                          },
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
                                  element.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                    Text(element.excerpt,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyText2),
                  ]),
            ));
      },
      itemComparator: (item1, item2) => item1.created.compareTo(item2.created),
      useStickyGroupSeparators: false,
      floatingHeader: false,
      order: GroupedListOrder.DESC,
    );
  }

  mobileWidget(BuildContext context) {
    return ListView.builder(
      reverse: false,
      itemCount: modelList.length,
      itemBuilder: (context, index) {
        ZHDetailModel element = modelList[index];
        return InkWell(
            onTap: () {
              Uri url;
              if (element.type == 'question') {
                url = Uri.parse('https://www.zhihu.com/question/${element.id}');
              } else {
                url = Uri.parse('https://zhuanlan.zhihu.com/p/${element.id}');
              }
              launchUrl(url);
            },
            child: style2(element, context));
      },
    );
  }

  style2(ZHDetailModel element, BuildContext context) {
    String timeTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(element.created) * 1000,
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
                      imageUrl: element.thumbnail!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const FlutterLogo()),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.8),
                          ])),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, top: 8, right: 12),
                        child: Text(
                          element.title,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText1,
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
                  element.excerpt,
                  style: Theme.of(context).textTheme.bodyText2,
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

  style1(ZHDetailModel element, BuildContext context) {
    String timeTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(element.created) * 1000,
    ).toString().substring(0, 16);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: element.thumbnail!,
              width: 120,
              height: 120 * 0.618,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return const FlutterLogo();
              },
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
              child: SizedBox(
                height: 120 * 0.618,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      element.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
          element.excerpt,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ]),
    );
  }
}
