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
            Uri url = Uri.parse(element.rawUrl);
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
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            timeTime,
                            style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey),
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
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: Colors.black54),
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
