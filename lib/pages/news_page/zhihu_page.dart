import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_statistics/models/zhihu_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ZhihuPage extends StatelessWidget {
  final List<ZHDetailModel> modelList;
  const ZhihuPage({super.key, required this.modelList});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(bottom: 8, top: 4),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              timeTime,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text(element.excerpt, maxLines: 5, style: Theme.of(context).textTheme.bodyMedium),
              ]),
            ));
      },
      itemComparator: (item1, item2) => item1.created.compareTo(item2.created),
      useStickyGroupSeparators: false,
      floatingHeader: false,
      order: GroupedListOrder.DESC,
    );
  }
}
