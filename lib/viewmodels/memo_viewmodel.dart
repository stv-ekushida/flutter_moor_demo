import 'package:flutter/cupertino.dart';
import 'package:flutter_moor_demo/models/model/memo.dart';
import 'package:flutter_moor_demo/models/repositories/memo_repository.dart';
import 'package:flutter_moor_demo/utils/memo_extensions.dart';

class MemoViewModel extends ChangeNotifier {
  final MemoRepository _repository;

  MemoViewModel({repository}) : _repository = repository;

  List<Memo> _memos = List<Memo>();
  List<Memo> get memos => _memos;

  Future<void> getMemos() async {
    print("[viewModel] : getMemos");
    await _repository.getMemos();
  }

  Future<void> addMemo(Memo memo) async {
    await _repository.addMemo(memo.toMemoEntity(memo));
  }

  Future<void> removeMemo(Memo memo) async {
    await _repository.removeMemo(memo.toMemoEntity(memo));
  }

  @override
  void dispose() {
    super.dispose();
  }

  onRepositoryUpdated(MemoRepository repository) {
    print("[viewModel] : onRepositoryUpdated");

    _memos = repository.memos;
    notifyListeners();
  }
}
