import 'package:flutter/cupertino.dart';
import 'package:flutter_moor_demo/models/db/database.dart';
import 'package:flutter_moor_demo/models/model/memo.dart';
import 'package:flutter_moor_demo/models/repositories/memo_repository.dart';
import 'package:flutter_moor_demo/utils/memo_extensions.dart';

class MemoViewModel extends ChangeNotifier {
  final MemoRepository _repository;

  MemoViewModel({repository}) : _repository = repository;

  List<Memo> _memos = List<Memo>();
  List<Memo> get memos => _memos;

  Future<void> getMemos() async {
    final List<MemoEntity> memoEntities = await _repository.getMemos();

    _memos = memoEntities.toMemos(memoEntities);
    notifyListeners();
  }

  Future<void> addMemo(Memo memo) async {
    await _repository.addMemo(memo.toMemoEntity(memo));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
