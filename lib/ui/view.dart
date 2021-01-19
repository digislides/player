import 'dart:html';

abstract class View {
  DivElement get root;
}

abstract class PageItemView implements View {
  void play();

  void stop();
}

String processForeignUrl(String url) {
  final uri = Uri.parse(url);
  if (uri.origin == 'echannel.se' ||
      uri.host == 'localhost' ||
      uri.host == '127.0.0.1') {
    return url;
  }

  final newUri = Uri(
      scheme: window.location.protocol,
      host: window.location.hostname,
      port: int.tryParse(window.location.port),
      path: '/external/media',
      queryParameters: {
        'url': url,
      });
  final newUrl = newUri.toString();
  return newUrl;
}