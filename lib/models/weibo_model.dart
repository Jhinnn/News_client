class WBDetailModel {
  late String title;
  late String scheme;
  late String itemid;
  late String create;

  WBDetailModel({
    required this.title,
    required this.scheme,
    required this.itemid,
    required this.create,
  });

  WBDetailModel.fromJson(Map<String, dynamic> json) {
    
    title = json['title'];
    scheme = json['scheme'];
    itemid = json['itemid'];
    create = json['create'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['scheme'] = scheme;
    data['itemid'] = itemid;
    data['create'] = create;
    
    return data;
  }
}

class WeiboModel {
  late int _ok;
  late Data _data;

  WeiboModel(int ok, Data data) {
    _ok = ok;
    _data = data;
  }

  get ok => _ok;
  Data get data => _data;

  WeiboModel.fromJson(Map<String, dynamic> json) {
    _ok = json['ok'];
    _data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = _ok;
    data['data'] = _data.toJson();
    return data;
  }
}

class Data {
  late List<Cards> _cards;

  Data(List<Cards> cards) {
    _cards = cards;
  }

  List<Cards> get cards => _cards;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      _cards = [];
      json['cards'].forEach((v) {
        _cards.add(Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cards'] = _cards.map((v) => v.toJson()).toList();
    return data;
  }
}

class Cards {
  late int _cardType;
  late String? _itemid;
  late String? _title;
  late List<CardGroup> _cardGroup;
  late int _showType;

  Cards(int cardType, String itemid, String title, List<CardGroup> cardGroup,
      int showType) {
    _cardType = cardType;
    _itemid = itemid;
    _title = title;
    _cardGroup = cardGroup;
    _showType = showType;
  }

  get cardType => _cardType;
  get itemid => _itemid;
  get title => _title;
  get cardGroup => _cardGroup;
  get showType => _showType;

  Cards.fromJson(Map<String, dynamic> json) {
    _cardType = json['card_type'];
    _itemid = json['itemid'];
    _title = json['title'];
    if (json['card_group'] != null) {
      _cardGroup = [];
      json['card_group'].forEach((v) {
        _cardGroup.add(CardGroup.fromJson(v));
      });
    }
    _showType = json['show_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_type'] = _cardType;
    data['itemid'] = _itemid;
    data['title'] = _title;
    data['card_group'] = _cardGroup.map((v) => v.toJson()).toList();
    data['show_type'] = _showType;
    return data;
  }
}

class CardGroup {
  int? _cardType;
  String? _scheme;
  String? _pic;
  String? _itemid;
  String? _icon;
  String? _desc;
  Actionlog? _actionlog;

  CardGroup(int cardType, String scheme, String pic, String itemid, String icon,
      String desc, Actionlog actionlog) {
    _cardType = cardType;
    _scheme = scheme;
    _pic = pic;
    _itemid = itemid;
    _icon = icon;
    _desc = desc;
    _actionlog = actionlog;
  }

  get cardType => _cardType;

  get scheme => _scheme;

  get pic => _pic;

  get itemid => _itemid;

  get icon => _icon;

  get desc => _desc;

  get actionlog => _actionlog;

  CardGroup.fromJson(Map<String, dynamic> json) {
    _cardType = json['card_type'];
    _scheme = json['scheme'];
    _pic = json['pic'];
    _itemid = json['itemid'];
    _icon = json['icon'];
    _desc = json['desc'];
    _actionlog = json['actionlog'] != null
        ? Actionlog.fromJson(json['actionlog'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_type'] = _cardType;
    data['scheme'] = _scheme;
    data['pic'] = _pic;
    data['itemid'] = _itemid;
    data['icon'] = _icon;
    data['desc'] = _desc;
    if (_actionlog != null) {
      data['actionlog'] = _actionlog!.toJson();
    }
    return data;
  }
}

class Actionlog {
  String? _lfid;
  String? _fid;
  String? _luicode;
  int? _actType;
  String? _uicode;
  int? _actCode;
  String? _ext;

  Actionlog(String lfid, String fid, String luicode, int actType, String uicode,
      int actCode, String ext) {
    _lfid = lfid;
    _fid = fid;
    _luicode = luicode;
    _actType = actType;
    _uicode = uicode;
    _actCode = actCode;
    _ext = ext;
  }

  get lfid => _lfid;
  get fid => _fid;
  get luicode => _luicode;
  get actType => _actType;
  get uicode => _uicode;
  get actCode => _actCode;
  get ext => _ext;

  Actionlog.fromJson(Map<String, dynamic> json) {
    _lfid = json['lfid'];
    _fid = json['fid'];
    _luicode = json['luicode'];
    _actType = json['act_type'];
    _uicode = json['uicode'];
    _actCode = json['act_code'];
    _ext = json['ext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lfid'] = _lfid;
    data['fid'] = _fid;
    data['luicode'] = _luicode;
    data['act_type'] = _actType;
    data['uicode'] = _uicode;
    data['act_code'] = _actCode;
    data['ext'] = _ext;
    return data;
  }
}
