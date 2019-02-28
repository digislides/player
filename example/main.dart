import 'dart:html';

import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:http/browser_client.dart';

import 'package:common/models.dart';
import 'package:player/preview.dart';
import 'package:wclient/utils/api/api.dart';

import 'package:player/service_worker/service_window.dart';

main() async {
  globalClient = BrowserClient();

  await window.navigator.serviceWorker.register('/player/sw.dart.js');

  final uri = Uri.parse(window.location.href);
  String id = uri.queryParameters['id'];

  Program program = await programApi.getById(id);
  if (program == null) {
    print('No program!');
    return;
  }

  print(program.design);

  await cacheProgramUrls(id, program.design);

  final view = ProgramView(program.design);

  document.body.children.add(view.root);
  // TODO view.start();
}
