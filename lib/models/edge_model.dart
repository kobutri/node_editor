import 'package:flutter/cupertino.dart';

import 'node_model.dart';

class EdgeModel {
  EdgeModel({@required this.start, this.end, this.endOffset}) {
    assert(start != null);
    assert(end == null && endOffset != null ||
        end != null && endOffset == null ||
        end == null && endOffset == null);
    startOffset =
        start.offset + Offset(start.size.width / 2, start.size.height / 2);
    endOffset = endOffset == null
        ? end != null
            ? end.offset + Offset(end.size.width / 2, end.size.height / 2)
            : startOffset
        : endOffset;
  }

  void update() {
    startOffset =
        start.offset + Offset(start.size.width / 2, start.size.height / 2);
    endOffset = end != null
        ? end.offset + Offset(end.size.width / 2, end.size.height / 2)
        : endOffset;
  }

  final NodeModel start;
  NodeModel end;
  Offset startOffset;
  Offset endOffset;
  bool destroyed = false;
}
