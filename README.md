## Bidirectional

# Dart grpc server + Flutter grpc client

using grpc and protobuf
![screenshot](https://github.com/ahrar-deriv/dart_flutter_grpc_poc/assets/98078754/514b7b4e-8349-4eb2-abcd-0dd1181e8afd)

### Benefits of gRPC Over WebSockets

#### Built-in Code Generation:

gRPC provides built-in support for code generation, making it easier to create strongly-typed clients and servers in multiple programming languages. This helps ensure that the client and server are always in sync regarding the data structures and service contracts.

#### HTTP/2 Based:

- gRPC leverages HTTP/2 for transport, which includes built-in support for multiplexing multiple requests over a single connection, flow control, header compression, and more efficient binary transmission.

#### Streaming Support:

- gRPC supports various types of streaming:
  Unary RPC: Single request followed by a single response.
  Server Streaming RPC: Single request followed by a stream of responses.
  Client Streaming RPC: Stream of requests followed by a single response.
  Bidirectional Streaming RPC: Both client and server can read and write streams of messages.

#### Performance:

- gRPC is designed for high performance with low latency and efficient binary serialization using Protocol Buffers (Protobuf). This can result in faster communication and lower bandwidth usage compared to WebSockets which typically use JSON.

#### Strongly Typed API:

- The use of Protocol Buffers ensures a strongly typed API, reducing the likelihood of errors caused by mismatched data types or missing fields.

#### Built-in Error Handling:

- gRPC has a well-defined error handling mechanism with status codes, making it easier to handle and debug errors.
