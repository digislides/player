import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:common/models.dart';
import 'package:player/preview.dart';

void main() {
  globalClient = BrowserClient();

  final uri = Uri.parse(window.location.href);
  String id = uri.queryParameters['id'];

  // TODO
}
