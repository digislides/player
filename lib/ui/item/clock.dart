import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class ClockItemView implements View {
  final ClockItem item;

  final root = DivElement();

  ClockItemView(this.item) {
    _build();
  }

  void _build() {
    // TODO
  }
}
