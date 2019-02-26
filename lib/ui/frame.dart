import 'dart:html';
import 'dart:async';
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

  PageView _currentPlaying;

  int _currentlyPlaying = 0;

  Timer _timer;

  void _playNext() {
    // Skip, if there are no pages
    if (_children.isEmpty) return;

    PageView nextPlay = _children[_currentlyPlaying];
    if (_currentPlaying != null) _currentPlaying.stop();
    nextPlay.play();
    _currentPlaying = nextPlay;
    _timer = Timer(Duration(seconds: nextPlay.page.duration), () {
      _currentlyPlaying++;
      if (_currentlyPlaying >= _children.length) _currentlyPlaying = 0;
      _playNext();
    });
  }

  void start() {
    _currentlyPlaying = 0;
    _playNext();
  }
}
