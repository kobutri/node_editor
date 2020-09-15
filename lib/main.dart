import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_editor/widgets/node_editor_widget.dart';
import 'package:provider/provider.dart';

import 'models/node_editor_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Cupertino App Bar'),
        ),
        child: SizeChangedLayoutNotifier(
          child: ChangeNotifierProvider<NodeEditorModel>(
            builder: (context, _) => SafeArea(
              child: SizedBox.expand(
                child: NodeEditor(),
              ),
            ),
            create: (_) => NodeEditorModel(),
          ),
        ),
      ),
    );
  }
}
