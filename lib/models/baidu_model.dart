//  "id"    INTEGER NOT NULL PRIMARY KEY,
//         "app_url"   TEXT,
//         "desc" TEXT,
//         "hot_score" TEXT,
//         "img"  TEXT,
//         "query"  TEXT,
//         "raw_url"  TEXT,
//         "url"  TEXT,
//         "word"  TEXT,
//         "update_time"  TEXT
class BDDetailModel {
  int? id;
  late String appUrl;
  late String desc;
  late String hotScore;
  String? img;
  late String query;
  late String rawUrl;
  late String url;
  late String word;
  late String updateTime;

  BDDetailModel(
      {this.id,
      required this.appUrl,
      required this.desc,
      required this.hotScore,
      this.img,
      required this.query,
      required this.rawUrl,
      required this.url,
      required this.word,
      required this.updateTime});

  BDDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUrl = json['app_url'];
    url = json['url'];
    desc = json['desc'];
    hotScore = json['hot_score'];
    img = json['img'];
    query = json['query'];
    rawUrl = json['raw_url'];
    url = json['url'];
    word = json['word'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['app_url'] = appUrl;
    data['desc'] = desc;
    data['hot_score'] = hotScore;
    data['img'] = img;
    data['query'] = query;
    data['raw_url'] = rawUrl;
    data['url'] = url;
    data['word'] = word;
    data['update_time'] = updateTime;
    return data;
  }
}

class BaiduModel {
  bool? success;
  Data? data;
  Error? error;

  BaiduModel({this.success, this.data, this.error});

  BaiduModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    if (error != null) {
      data['error'] = error?.toJson();
    }
    return data;
  }
}

class Data {
  List<Cards>? cards;
  String? curBoardName;
  String? logid;
  String? platform;
  List<TabBoard>? tabBoard;
  List? tag;

  Data(
      {this.cards,
      this.curBoardName,
      this.logid,
      this.platform,
      this.tabBoard,
      this.tag});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards?.add(Cards.fromJson(v));
      });
    }
    curBoardName = json['curBoardName'];
    logid = json['logid'];
    platform = json['platform'];
    if (json['tabBoard'] != null) {
      tabBoard = <TabBoard>[];
      json['tabBoard'].forEach((v) {
        tabBoard?.add(TabBoard.fromJson(v));
      });
    }
    // if (json['tag'] != null) {
    //   tag = <Null>[];
    //   json['tag'].forEach((v) {
    //     tag?.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cards != null) {
      data['cards'] = cards?.map((v) => v.toJson()).toList();
    }
    data['curBoardName'] = curBoardName;
    data['logid'] = logid;
    data['platform'] = platform;
    if (tabBoard != null) {
      data['tabBoard'] = tabBoard?.map((v) => v.toJson()).toList();
    }
    // if (tag != null) {
    //   data['tag'] = tag?.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Cards {
  String? component;
  List<Content>? content;
  int? more;
  String? moreAppUrl;
  String? moreUrl;
  String? text;
  List<TopContent>? topContent;
  String? typeName;
  String? updateTime;

  Cards(
      {this.component,
      this.content,
      this.more,
      this.moreAppUrl,
      this.moreUrl,
      this.text,
      this.topContent,
      this.typeName,
      this.updateTime});

  Cards.fromJson(Map<String, dynamic> json) {
    component = json['component'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content?.add(Content.fromJson(v));
      });
    }
    more = json['more'];
    moreAppUrl = json['moreAppUrl'];
    moreUrl = json['moreUrl'];
    text = json['text'];
    if (json['topContent'] != null) {
      topContent = <TopContent>[];
      json['topContent'].forEach((v) {
        topContent?.add(TopContent.fromJson(v));
      });
    }
    typeName = json['typeName'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['component'] = component;
    if (content != null) {
      data['content'] = content?.map((v) => v.toJson()).toList();
    }
    data['more'] = more;
    data['moreAppUrl'] = moreAppUrl;
    data['moreUrl'] = moreUrl;
    data['text'] = text;
    if (topContent != null) {
      data['topContent'] = topContent?.map((v) => v.toJson()).toList();
    }
    data['typeName'] = typeName;
    data['updateTime'] = updateTime;
    return data;
  }
}

class Content {
  String? appUrl;
  String? desc;
  String? hotChange;
  String? hotScore;
  String? hotTag;
  String? hotTagImg;
  String? img;
  int? index;
  String? query;
  String? rawUrl;
  List? show;
  String? url;
  String? word;

  Content(
      {this.appUrl,
      this.desc,
      this.hotChange,
      this.hotScore,
      this.hotTag,
      this.hotTagImg,
      this.img,
      this.index,
      this.query,
      this.rawUrl,
      this.show,
      this.url,
      this.word});

  Content.fromJson(Map<String, dynamic> json) {
    appUrl = json['appUrl'];
    desc = json['desc'];
    hotChange = json['hotChange'];
    hotScore = json['hotScore'];
    hotTag = json['hotTag'];
    hotTagImg = json['hotTagImg'];
    img = json['img'];
    index = json['index'];
    query = json['query'];
    rawUrl = json['rawUrl'];
    // if (json['show'] != null) {
    //   show = <Null>[];
    //   json['show'].forEach((v) {
    //     show?.add(Null.fromJson(v));
    //   });
    // }
    url = json['url'];
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appUrl'] = appUrl;
    data['desc'] = desc;
    data['hotChange'] = hotChange;
    data['hotScore'] = hotScore;
    data['hotTag'] = hotTag;
    data['hotTagImg'] = hotTagImg;
    data['img'] = img;
    data['index'] = index;
    data['query'] = query;
    data['rawUrl'] = rawUrl;
    if (show != null) {
      data['show'] = show?.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    data['word'] = word;
    return data;
  }
}

class TopContent {
  String? appUrl;
  String? desc;
  String? hotChange;
  String? hotScore;
  String? hotTag;
  String? img;
  int? index;
  String? query;
  String? rawUrl;
  // List? show;
  String? url;
  String? word;

  TopContent(
      {this.appUrl,
      this.desc,
      this.hotChange,
      this.hotScore,
      this.hotTag,
      this.img,
      this.index,
      this.query,
      this.rawUrl,
      // this.show,
      this.url,
      this.word});

  TopContent.fromJson(Map<String, dynamic> json) {
    appUrl = json['appUrl'];
    desc = json['desc'];
    hotChange = json['hotChange'];
    hotScore = json['hotScore'];
    hotTag = json['hotTag'];
    img = json['img'];
    index = json['index'];
    query = json['query'];
    rawUrl = json['rawUrl'];
    // if (json['show'] != null) {
    //   show = <Null>[];
    //   json['show'].forEach((v) {
    //     show?.add(Null.fromJson(v));
    //   });
    // }
    url = json['url'];
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appUrl'] = appUrl;
    data['desc'] = desc;
    data['hotChange'] = hotChange;
    data['hotScore'] = hotScore;
    data['hotTag'] = hotTag;
    data['img'] = img;
    data['index'] = index;
    data['query'] = query;
    data['rawUrl'] = rawUrl;
    // if (show != null) {
    //   data['show'] = show.map((v) => v.toJson()).toList();
    // }
    data['url'] = url;
    data['word'] = word;
    return data;
  }
}

class TabBoard {
  int? index;
  String? text;
  String? typeName;

  TabBoard({this.index, this.text, this.typeName});

  TabBoard.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    text = json['text'];
    typeName = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['text'] = text;
    data['typeName'] = typeName;
    return data;
  }
}

class Error {
  int? code;
  String? message;

  Error({this.code, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
