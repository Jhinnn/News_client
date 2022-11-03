import 'package:data_statistics/db/table_define.dart';
import 'package:data_statistics/db/table_operation.dart';
import 'package:data_statistics/models/baidu_model.dart';
import 'package:sqflite/sqflite.dart';

class BaiduTable extends TableOperation {
  Future<List<BDDetailModel>> query() async {
    List<Map<String, Object?>> data =
        await dDatabase.query(DSTableDefine.baiduTable,orderBy: 'update_time DESC');
    return List.generate(data.length, (index) {
      return BDDetailModel.fromJson(data[index]);
    });
  }

  Future<bool> queryTitle(String query) async {
    List<Map<String, Object?>> list = await dDatabase.query(
        DSTableDefine.baiduTable,
        where: 'query = ?',
        whereArgs: [query]);
    return list.isEmpty;
  }

  Future<void> insertHot(BDDetailModel bdDetailModel) async {
    if (await queryTitle(bdDetailModel.query)) {
      await dDatabase.insert(DSTableDefine.baiduTable, bdDetailModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<int> clearAll() async {
    return await dDatabase.delete(DSTableDefine.baiduTable);
  }
}
