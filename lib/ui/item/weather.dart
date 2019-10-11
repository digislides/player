import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:common/data/data_repo.dart';
import 'package:common/models.dart';
import '../view.dart';

class WeatherItemView implements PageItemView {
  final WeatherItem item;

  final root = DivElement();

  WeatherItemView(this.item) {
    _update(null);
    _build();
  }

  Weather weather = dummyWeather; // TODO

  void _build() {
    root.children.clear();

    root.classes
        .addAll(['page-item', 'page-item-weather', 'page-item-${item.id}']);

    root.style
      ..width = '${item.width}px'
      ..height = '${item.height}px'
      ..left = '${item.left}px'
      ..top = '${item.top}px'
      ..color = item.color;

    root.children.add(DivElement()
      ..classes.add('main-info')
      ..style.fontSize = '${item.width * 0.3}px'
      ..children.add(DivElement()
        ..classes.add('weather-icon')
        ..style.marginRight = '${item.width * 0.05}px'
        ..text = WeatherIconType.values[weather.condition.icon].char)
      ..children.add(DivElement()
        ..classes.add('temperature')
        ..children.addAll([
          SpanElement()..text = weather.temp.toString(),
          SpanElement()
            ..classes.add('unit')
            ..style.fontSize = "${item.width * 0.1}px"
            ..text = '°C'
        ])));

    root.children.add(DivElement()
      ..classes.add('extra-info')
      ..children.add(DivElement()
        ..classes.add('extra-info-item')
        ..style.fontSize = '${item.width * 0.05}px'
        ..style.marginRight = '${item.width * 0.1}px'
        ..children.addAll([
          DivElement()
            ..classes.add('weather-icon')
            ..style.marginRight = "${item.width * 0.02}px"
            ..text = '\uf021',
          DivElement()..text = '${weather.wind.speed} MPH'
        ]))
      ..children.add(DivElement()
        ..classes.add('extra-info-item')
        ..style.fontSize = '${item.width * 0.05}px'
        ..children.addAll([
          DivElement()
            ..classes.add('weather-icon')
            ..style.marginRight = "${item.width * 0.02}px"
            ..text = '\uf07a',
          DivElement()..text = '${weather.humidity}%'
        ])));
  }

  Timer _timer;

  @override
  void play() {
    _timer = Timer.periodic(Duration(minutes: 10), _update);
  }

  @override
  void stop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void _update(_) {
    final info =
        item.dataRepository.substitute(DataLink(['weather', item.place], {}));
    if (info.isEmpty) {
      weather = dummyWeather; // TODO
      return;
    }
    weather = Weather.serializer.fromMap(jsonDecode(info));
  }
}
