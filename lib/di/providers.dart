import 'package:flutter_moor_demo/models/db/dao.dart';
import 'package:flutter_moor_demo/models/db/database.dart';
import 'package:flutter_moor_demo/models/repositories/memo_repository.dart';
import 'package:flutter_moor_demo/viewmodels/memo_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<AppDatabase>(
    create: (_) => AppDatabase(),
    dispose: (_, db) => db.close(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<AppDatabase, MemoDao>(
    update: (context, db, dao) => MemoDao(db),
  ),
  ChangeNotifierProvider<MemoRepository>(
    create: (context) =>
        MemoRepository(dao: Provider.of<MemoDao>(context, listen: false)),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProxyProvider<MemoRepository, MemoViewModel>(
    create: (context) => MemoViewModel(
      repository: Provider.of<MemoRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) =>
        viewModel..onRepositoryUpdated(repository),
  )
];
