import 'dart:html';
import 'frame.dart';

import 'package:common/models.dart';
import 'view.dart';

class ProgramView implements View {
  final ProgramDesign program;

  final root = DivElement();

  ProgramView(this.program) {
    _build();
  }

  final _children = <FrameView>[];

  @override
  void _build() {
    root.classes.addAll(['program']);

    root.style.left = '0px';
    root.style.top = '0px';
    root.style.width = '${program.width}px';
    root.style.height = '${program.height}px';

    for (final frame in program.frames) {
      final view = FrameView(frame);
      _children.add(view);
      root.children.add(view.root);
    }
  }

  void start() {
    for (final child in _children) {
      child.start();
    }
  }

  void purge() {
    // TODO
    root.remove();
  }
}
