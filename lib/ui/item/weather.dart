import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class WeatherItemView implements View {
  final WeatherItem item;

  final root = DivElement();

  WeatherItemView(this.item);

  void build() {
    // TODO
  }
}
