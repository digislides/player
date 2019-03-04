import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class WeatherItemView implements PageItemView {
  final WeatherItem item;

  final root = DivElement();

  WeatherItemView(this.item) {
    _build();
  }

  void _build() {
    // TODO
  }

  @override
  void play() {}

  @override
  void stop() {}
}
