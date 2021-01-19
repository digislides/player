import 'dart:html';
import 'frame.dart';

import 'package:common/models.dart';
import 'view.dart';

class ProgramView implements View {
  final ProgramDesign program;

  final root = DivElement();

  final bool isPreview;

  ProgramView(this.program, {this.isPreview = true}) {
    _build();
  }

  final _children = <FrameView>[];

  void _build() {
    root.classes.addAll(['program']);

    root.style.left = '0px';
    root.style.top = '0px';
    root.style.width = '${program.width}px';
    root.style.height = '${program.height}px';

    root.style.backgroundColor = program.color;
    root.style.backgroundImage =
        isPreview ? program.imageUrl : processForeignUrl(program.imageUrl);
    root.style.backgroundRepeat = program.fit.repeatCss;
    root.style.backgroundSize = program.fit.sizeCss;

    for (final frame in program.frames) {
      final view = FrameView(frame, isPreview: isPreview);
      _children.add(view);
      root.children.add(view.root);
    }
  }

  Future<void> start() async {
    try {
      await program.dataRepository.start();
    } catch (e) {}
    for (final child in _children) {
      child.start();
    }
  }

  Future<void> purge() async {
    try {
      await program.dataRepository.stop();
    } catch (e) {}
    root.remove();
  }
}
