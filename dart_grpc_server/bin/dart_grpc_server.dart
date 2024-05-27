import 'dart:async';

import 'package:fixnum/src/int64.dart';
import 'package:grpc/grpc.dart';
import 'package:dart_grpc_server/src/generated/service.pbgrpc.dart';

class ChatService extends ChatServiceBase {
  @override
  Stream<ChatMessage> chat(
      ServiceCall call, Stream<ChatMessage> request) async* {
    await for (var message in request) {
      print('Received message from ${message.sender}: ${message.message}');
      yield ChatMessage()
        ..message = 'Hello from Server'
        ..sender = 'Server'
        ..timestamp = Int64(DateTime.now().millisecondsSinceEpoch);
    }
  }
}

Future<void> main(List<String> args) async {
  final server = Server.create(services: [ChatService()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
