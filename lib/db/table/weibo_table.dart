import 'package:data_statistics/db/table_define.dart';
import 'package:data_statistics/db/table_operation.dart';
import 'package:data_statistics/models/weibo_model.dart';
import 'package:sqflite/sqflite.dart';

class WeiboTable extends TableOperation {
  Future<List<WBDetailModel>> query() async {


    List<Map<String, Object?>> data =
        await dDatabase.query(DSTableDefine.weiboTable);
    return List.generate(data.length, (index) {
      return WBDetailModel.fromJson(data[index]);
    });
  }

  Future<bool> queryTitle(String title) async {
    List<Map<String, Object?>> list = await dDatabase.query(
        DSTableDefine.weiboTable,
        where: 'title = ?',
        whereArgs: [title]);
    return list.isEmpty;
  }

  Future<void> insertHot(WBDetailModel bdDetailModel) async {
    if (await queryTitle(bdDetailModel.title)) {
      await dDatabase.insert(DSTableDefine.weiboTable, bdDetailModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<int> clearAll() async {
    return await dDatabase.delete(DSTableDefine.weiboTable);
  }
}
