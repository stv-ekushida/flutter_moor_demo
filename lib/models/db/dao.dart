import 'package:flutter_moor_demo/models/db/database.dart';
import 'package:moor/moor.dart';

part 'dao.g.dart';

@UseDao(tables: [MemoEntities])
class MemoDao extends DatabaseAccessor<AppDatabase> with _$MemoDaoMixin {
  MemoDao(AppDatabase db) : super(db);

  //全削除
  Future clearAll() => delete(memoEntities).go();

  //該当のデータ削除
  Future clearById(MemoEntity memo) =>
      (delete(memoEntities)..where((m) => m.id.equals(memo.id))).go();

  //登録
  Future insert(MemoEntity memo) async {
    await into(memoEntities).insert(memo);
  }

  //読み出し（登録日の降順）
  Future<List<MemoEntity>> get findAllOrderByCreated => (select(memoEntities)
        ..orderBy([
          (m) => OrderingTerm(expression: m.created, mode: OrderingMode.desc)
        ]))
      .get();
}
