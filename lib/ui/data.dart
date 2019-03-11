import 'dart:async';

import 'package:common/data_text/data_text.dart';

import 'package:common/models.dart';
import 'package:wclient/utils/api/api.dart';

class WeatherData extends DataSource {
  final List<String> template = ['weather', ':place', ':param'];

  final _weathers = <String, Weather>{};

  Timer _timer;

  WeatherData() {
    _timer = Timer.periodic(Duration(minutes: 10), (_) async {
      await _update();
    });
  }

  void register(String place) {
    _weathers[place] = null;
  }

  Future<void> start() async {
    await _update();
  }

  Future<void> _update() async {
    for (String weather in _weathers.keys) {
      try {
        _weathers[weather] = await weatherApi.getByName(weather);
      } catch (e) {}
    }
  }

  String toData(Weather weather, String param) {
    switch (param) {
      case 'temperature':
        return weather.temp?.toString();
      default:
        return '';
    }
  }

  @override
  String get(DataLink link) {
    final String places = getParam(":place", link.segments);
    final String param = getParam(":param", link.segments);
    final weather = _weathers[places];
    if (weather == null) return "";
    return toData(weather, param);
  }

  void dispose() {
    if (_timer != null) _timer.cancel();
  }
}
