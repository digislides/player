import 'dart:html';
import 'dart:async';

import 'package:common/models.dart';
import '../view.dart';
import 'package:wclient/src/utils/components/clock.dart';

class ClockItemView implements PageItemView {
  final ClockItem item;

  final bool isPreview;

  final root = DivElement();

  final _clockComp = ClockComponent();

  ClockItemView(this.item, {this.isPreview = true}) {
    _build();
  }

  void _build() {
    // TODO background

    _clockComp.timezone = item.timezone;
    _clockComp.time = DateTime.now();
    _clockComp.textColor = item.textColor;
    _clockComp.color = item.color;
    _clockComp.image =
        isPreview ? item.imageUrl : processForeignUrl(item.imageUrl);
    _clockComp.hourColor = item.hourColor;
    _clockComp.minuteColor = item.minuteColor;

    root
      ..classes.addAll(['page-item', 'page-item-clock', 'page-item-${item.id}'])
      ..children.add(_clockComp.root);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';
  }

  Timer _timer;

  @override
  void play() {
    if (_timer != null) throw Exception("Unexpected behavior!");

    _clockComp.time = DateTime.now();
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      _clockComp.time = DateTime.now();
    });
  }

  @override
  void stop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}
