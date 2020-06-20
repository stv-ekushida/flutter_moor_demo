import 'package:flutter_moor_demo/models/db/database.dart';
import 'package:flutter_moor_demo/models/model/memo.dart';

extension ConvertToMemoEntities on List<Memo> {
  List<MemoEntity> toMemoEntities(List<Memo> memos) {
    var memoEntities = List<MemoEntity>();

    memos.forEach((memo) {
      memoEntities.add(MemoEntity(
          id: memo.id,
          title: memo.title ?? "",
          content: memo.content ?? "",
          created: memo.created));
    });
    return memoEntities;
  }
}

extension ConvertToMemoEntity on Memo {
  MemoEntity toMemoEntity(Memo memo) {
    var memoEntity = MemoEntity(
      id: memo.id,
      title: memo.title ?? "",
      content: memo.content ?? "",
      created: memo.created,
    );
    return memoEntity;
  }
}

extension ConvertToMemos on List<MemoEntity> {
  List<Memo> toMemos(List<MemoEntity> memoEntities) {
    var memos = List<Memo>();

    memoEntities.forEach((memo) {
      memos.add(Memo(
          id: memo.id ?? "",
          title: memo.title ?? "",
          content: memo.content ?? "",
          created: memo.created ?? ""));
    });
    return memos;
  }
}
