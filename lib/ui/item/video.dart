import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class VideoItemView implements View {
  final VideoItem item;

  final root = DivElement();

  VideoItemView(this.item) {
    _build();
  }

  void _build() {
    // TODO
  }
}
