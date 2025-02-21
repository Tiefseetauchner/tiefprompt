import 'dart:io';

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 3824);
  print('Screenshot server running on http://0.0.0.0:3824');

  await for (HttpRequest request in server) {
    print('Request: ${request.method} ${request.uri}');
    print('Headers: ${request.headers}');

    if (request.method == 'GET' && request.uri.path == '/health') {
      request.response
        ..statusCode = HttpStatus.ok
        ..write('true')
        ..close();
    } else if (request.method == 'POST' &&
        request.uri.path.startsWith('/screenshots/')) {
      final fileName = request.uri.pathSegments.last;
      final file = File('screenshots/$fileName');

      await file.create(recursive: true);
      await file.writeAsBytes(await request
          .fold<List<int>>([], (buffer, data) => buffer..addAll(data)));

      request.response
        ..statusCode = HttpStatus.ok
        ..write('Screenshot saved as $fileName')
        ..close();

      print('Saved: screenshots/$fileName');
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not Found')
        ..close();
    }
  }
}
