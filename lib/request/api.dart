import 'package:data_statistics/models/baidu_model.dart';
import 'package:data_statistics/models/weibo_model.dart' as weibo;
import 'package:data_statistics/models/zhihu_model.dart';
import 'package:dio/dio.dart';

class Api {

  static Future<List<Cards>?> fetchBaidu() async {
    Map<String, dynamic> header = {
      'User-Agent':
          'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Mobile Safari/537.36',
      'Host': 'top.baidu.com',
      'Accept': 'application/json, text/plain, */*',
      'Accept-Language': 'zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7',
      'Accept-Encoding': 'gzip, deflate, br',
      'Referer': 'https://top.baidu.com/board?tab=novel',
    };

    Dio dio = Dio();
    BaseOptions baseOptions = BaseOptions(headers: header);
    dio.options = baseOptions;
    var data = await Dio()
        .get('https://top.baidu.com/api/board?platform=wise&tab=realtime');

    BaiduModel baiduModel = BaiduModel.fromJson(data.data);
    return baiduModel.data!.cards;
  }

  static Future<List<ZHModel>> fetchZhihuPackages() async {
    try {
      var data = await Dio().get('https://api.zhihu.com/topstory/hot-list');
      ZhiHuModel zhiHuModel = ZhiHuModel.fromJson(data.data);
      return zhiHuModel.data!;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<List<weibo.CardGroup>> fetchWeiboPackages() async {
    var data = await Dio().get(
        'https://m.weibo.cn/api/container/getIndex?containerid=106003type%3D25%26t%3D3%26disable_hot%3D1%26filter_type%3Drealtimehot');
    weibo.WeiboModel weiboModel = weibo.WeiboModel.fromJson(data.data);
    return weiboModel.data.cards.first.cardGroup;
  }
}
