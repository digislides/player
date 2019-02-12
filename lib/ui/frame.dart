import 'dart:html';
import 'page.dart';

import 'package:common/models.dart';
import 'view.dart';

class FrameView implements View {
  final Frame frame;

  final root = DivElement();

  FrameView(this.frame) {
    _build();
  }

  final _children = <View>[];

  void _build() {
    root.classes.addAll(['frame', 'frame-${frame.id}']);

    root.style.left = '${frame.left}px';
    root.style.top = '${frame.top}px';
    root.style.width = '${frame.width}px';
    root.style.height = '${frame.height}px';

    for (final page in frame.pages) {
      final child = PageView(page);
      _children.add(child);
      root.children.add(child.root);
    }
  }
}
