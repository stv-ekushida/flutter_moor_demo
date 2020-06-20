import 'package:flutter/material.dart';
import 'package:flutter_moor_demo/models/db/dao.dart';
import 'package:flutter_moor_demo/models/db/database.dart';
import 'package:flutter_moor_demo/models/model/memo.dart';
import 'package:flutter_moor_demo/utils/memo_extensions.dart';

class MemoRepository extends ChangeNotifier {
  final MemoDao _dao;

  MemoRepository({dao}) : _dao = dao;

  List<Memo> _memos = List<Memo>();
  List<Memo> get memos => _memos;

  getMemos() async {
    print("[Repository] : getMemos");

    List<MemoEntity> result = await _dao.findAllOrderByCreated;
    _memos = result.toMemos(result);
    notifyListeners();
  }

  Future<int> addMemo(MemoEntity memo) async {
    return await _dao.insert(memo);
  }

  Future<void> removeMemo(MemoEntity memo) async {
    return await _dao.clearById(memo);
  }
}
