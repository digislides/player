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

  void _build() {
    root.classes.addAll(['frame', 'frame-${frame.id}']);

    root.style.left = '${frame.left}px';
    root.style.top = '${frame.top}px';
    root.style.width = '${frame.width}px';
    root.style.height = '${frame.height}px';

    root.style.backgroundColor = frame.color;
    root.style.backgroundImage = frame.imageUrl;
    root.style.backgroundRepeat = frame.fit.repeatCss;
    root.style.backgroundSize = frame.fit.sizeCss;

    root.children.add(_holder);
  }

  PageView _currentPlaying;

  int _currentlyPlaying = -1;

  Timer _timer;

  void _playNext() {
    // Skip, if there are no pages
    if (frame.pages.isEmpty) return;

    bool hasNext = _getNext();

    PageView nextPlay;
    if (hasNext) {
      nextPlay = PageView(frame.pages[_currentlyPlaying], frame.transition);
    }

    if (_currentPlaying != null) {
      final cp = _currentPlaying;
      cp.stop(exitTransition: nextPlay?.transition ?? Transition.none);
    }

    if (hasNext) {
      _holder.children.add(nextPlay.root);
      nextPlay.play();
      _currentPlaying = nextPlay;
      _timer = Timer(Duration(seconds: nextPlay.page.duration), () {
        _playNext();
      });
    } else {
      _currentPlaying == null;
      _timer = Timer(Duration(minutes: 1), () {
        _playNext();
      });
    }
  }

  bool _getNext() {
    int newP = _currentlyPlaying;

    do {
      newP++;
      if (newP >= frame.pages.length) newP = 0;

      final page = frame.pages[newP];
      if (page.schedule.canRun(DateTime.now())) {
        _currentlyPlaying = newP;
        return true;
      }
    } while (_currentlyPlaying != newP);

    return false;
  }

  void start() {
    _currentlyPlaying = -1;
    _playNext();
  }

  void stop() {}
}
