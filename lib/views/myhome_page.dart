import 'package:flutter/material.dart';
import 'package:flutter_moor_demo/models/model/memo.dart';
import 'package:flutter_moor_demo/viewmodels/memo_viewmodel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    _loadMemos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Memo List"),
      ),
      body: Container(
        color: Colors.white,
        child: Consumer<MemoViewModel>(
          builder: (context, model, child) {
            return ListView.builder(
                itemCount: model.memos.length,
                itemBuilder: (context, int position) => Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(model.memos[position].title),
                          subtitle: Text(model.memos[position].created
                              .toStringCreated(model.memos[position].created)),
                        ),
                      ),
                      actions: [
                        IconSlideAction(
                          caption: '削除',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            _remove(model.memos[position]);
                          },
                        )
                      ],
                    ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addMemo,
      ),
    );
  }

  void _loadMemos() {
    final MemoViewModel viewModel =
        Provider.of<MemoViewModel>(context, listen: false);
    Future(() => viewModel.getMemos());
  }

  _addMemo() {
    final MemoViewModel viewModel =
        Provider.of<MemoViewModel>(context, listen: false);
    var memo =
        Memo(title: "title", content: "content", created: DateTime.now());

    viewModel.addMemo(memo);
    _loadMemos();
  }

  _remove(Memo memo) {
    final MemoViewModel viewModel =
        Provider.of<MemoViewModel>(context, listen: false);

    viewModel.removeMemo(memo);
    _loadMemos();
  }
}
