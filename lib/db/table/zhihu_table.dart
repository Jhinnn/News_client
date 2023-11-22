import 'package:data_statistics/db/table_define.dart';
import 'package:data_statistics/db/table_operation.dart';
import 'package:data_statistics/models/zhihu_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ZhihuTable extends TableOperation {
  Future<List<ZHDetailModel>> query() async {
    List<Map<String, Object?>> data = await dDatabase.query(DSTableDefine.zhihuTable);
    return List.generate(data.length, (index) {
      return ZHDetailModel.fromJson(data[index]);
    });
  }

  Future<int> insertHot(ZHDetailModel zhDetailModel) async {
    return await dDatabase.insert(DSTableDefine.zhihuTable, zhDetailModel.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
