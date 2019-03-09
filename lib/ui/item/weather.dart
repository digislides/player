import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class WeatherItemView implements PageItemView {
  final WeatherItem item;

  final root = DivElement();

  WeatherItemView(this.item) {
    _build();
  }

  final _icon = DivElement();

  void _build() {
    root.classes
        .addAll(['page-item', 'page-item-weather', 'page-item-${item.id}']);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';

    _icon.style.width = "100%";
    _icon.style.height = "100%";

    _icon.classes.addAll([item.theme.css]);
    _icon.classes.add(item.dummy.css);

    _icon.style.backgroundColor = item.color;

    root.children.add(_icon);
  }

  @override
  void play() {
    // TODO
  }

  @override
  void stop() {
    // TODO
  }
}
