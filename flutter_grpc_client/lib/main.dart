import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'src/generated/service.pbgrpc.dart';
import 'package:fixnum/fixnum.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter gRPC Bidirectional Streaming Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ClientChannel channel;
  late ChatServiceClient stub;
  late StreamController<ChatMessage> requestStreamController;
  List<ChatMessage> receivedMessages = [];

  @override
  void initState() {
    super.initState();
    _setupGrpc();
  }

  void _setupGrpc() {
    channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = ChatServiceClient(channel);

    requestStreamController = StreamController<ChatMessage>();

    _startChat();
  }

  void _startChat() async {
    final call = stub.chat(requestStreamController.stream);

    // Listen for responses from the server
    call.listen((response) {
      setState(() {
        receivedMessages.add(response);
      });
    });

    // Send messages periodically to the server
    Stream.periodic(Duration(seconds: 1), (i) {
      return ChatMessage(
        message: 'Hello from Flutter',
        sender: 'FlutterClient',
        timestamp: Int64(DateTime.now().millisecondsSinceEpoch),
      );
    }).listen((msg) {
      requestStreamController.add(msg);
    });
  }

  @override
  void dispose() {
    requestStreamController.close();
    channel.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter gRPC Bidirectional Streaming Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: receivedMessages.length,
          itemBuilder: (context, index) {
            final msg = receivedMessages[index];
            return ListTile(
              title: Text(msg.message),
              subtitle: Text(
                  '${msg.sender} @ ${DateTime.fromMillisecondsSinceEpoch(msg.timestamp.toInt())}'),
            );
          },
        ),
      ),
    );
  }
}
