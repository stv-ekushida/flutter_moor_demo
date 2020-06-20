import 'package:flutter_moor_demo/models/db/dao.dart';
import 'package:flutter_moor_demo/models/db/database.dart';

class MemoRepository {
  final MemoDao _dao;

  MemoRepository({dao}) : _dao = dao;

  Future<List<MemoEntity>> getMemos() async {
    List<MemoEntity> result = List<MemoEntity>();

    result = await _dao.findAllOrderByCreated;
    return result;
  }

  Future<int> addMemo(MemoEntity memo) async {
    return await _dao.insert(memo);
  }
}
