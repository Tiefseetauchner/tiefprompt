import 'dart:io';

void main() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3824);
  print('Screenshot server running on http://127.0.0.1:3824');

  await for (HttpRequest request in server) {
    print('Request: ${request.method} ${request.uri}');
    print('Headers: ${request.headers}');

    if (request.method == 'GET' && request.uri.path == '/health') {
      request.response
        ..statusCode = HttpStatus.ok
        ..write('true')
        ..close();
    } else if (request.method == 'POST' &&
        request.uri.path.startsWith('/screenshots/') &&
        !request.uri.pathSegments.contains('..')) {
      final screenshotPath = request.uri.pathSegments.join('/');
      final file = File(screenshotPath);

      await file.create(recursive: true);
      await file.writeAsBytes(
        await request.fold<List<int>>(
          [],
          (buffer, data) => buffer..addAll(data),
        ),
      );

      request.response
        ..statusCode = HttpStatus.ok
        ..write('Screenshot saved as $screenshotPath')
        ..close();

      print('Saved: $screenshotPath');
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not Found')
        ..close();
    }
  }
}
