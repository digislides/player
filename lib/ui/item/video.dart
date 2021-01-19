import 'dart:html';

import 'package:common/models.dart';
import '../view.dart';

class VideoItemView implements PageItemView {
  final VideoItem item;

  final bool isPreview;

  final root = DivElement();

  final video = VideoElement();

  VideoItemView(this.item, {this.isPreview = true}) {
    _build();
  }

  void _build() {
    root.classes
        .addAll(['page-item', 'page-item-video', 'page-item-${item.id}']);

    root.style.width = '${item.width}px';
    root.style.height = '${item.height}px';

    root.style.left = '${item.left}px';
    root.style.top = '${item.top}px';

    root.style.backgroundColor = item.color;

    video..style.objectFit = item.fit.css;
    video.style.width = "100%";
    video.style.height = "100%";
    video.muted = item.muted;
    video.children.add(SourceElement()
      ..src = isPreview ? item.videoUrl : processForeignUrl(item.videoUrl));

    root.children.add(video);
  }

  @override
  void play() {
    video.currentTime = 0;
    video.play();
  }

  @override
  void stop() {
    video.pause();
  }
}
