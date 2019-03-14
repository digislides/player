import 'dart:html';
import 'dart:async';
import 'page.dart';

import 'package:common/models.dart';
import 'view.dart';

class FrameView implements View {
  final Frame frame;

  final root = DivElement();

  final _holder = DivElement()..classes.add('holder');

  FrameView(this.frame) {
    _build();
  }

  // final _children = <View>[];

  void _build() {
    root.classes.addAll(['frame', 'frame-${frame.id}']);

    root.style.left = '${frame.left}px';
    root.style.top = '${frame.top}px';
    root.style.width = '${frame.width}px';
    root.style.height = '${frame.height}px';

    root.children.add(_holder);

    /*
    for (final page in frame.pages) {
      final child = PageView(page);
      _children.add(child);
      root.children.add(child.root);
    }
    */
  }

  PageView _currentPlaying;

  int _currentlyPlaying = 0;

  Timer _timer;

  void _playNext() {
    // Skip, if there are no pages
    if (frame.pages.isEmpty) return;

    PageView nextPlay = PageView(frame.pages[_currentlyPlaying]);
    if (_currentPlaying != null) {
      final cp = _currentPlaying;
      // TODO perform exit transition
      cp.stop(transition: nextPlay.page.transition);
      // TODO _currentPlaying.root.remove();
    }
    _holder.children.add(nextPlay.root);
    nextPlay.play();
    _currentPlaying = nextPlay;
    _timer = Timer(Duration(seconds: nextPlay.page.duration), () {
      _currentlyPlaying++;
      if (_currentlyPlaying >= frame.pages.length) _currentlyPlaying = 0;
      _playNext();
    });
  }

  void start() {
    _currentlyPlaying = 0;
    _playNext();
  }

  void stop() {}
}
