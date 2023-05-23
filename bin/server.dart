import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/search/<query>', _echoHandler);

Response _rootHandler(Request req) {
  return Response.ok('Google Search API!\n');
}

Future<Response> _echoHandler(Request request) async {
  final query = request.params['query'];
  if (query != null) {
    final result = await searchOnGoogle(query);
    return Response.ok(result);
  }
  return Response.badRequest(body: 'Missing query param');
}

Future<String> searchOnGoogle(String query) async {
  final encodedQuery = Uri.encodeComponent(query);
  var env = DotEnv(includePlatformEnvironment: true)..load();
  final apiKey = env['KEY'];
  final url =
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=24ff674370c5c406b&q=$encodedQuery';
  final response = await http.get(Uri.parse(url));
  return response.body;
}

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
