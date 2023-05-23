A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Running the sample

## Running with the Dart SDK

Crie um arquivo .env na raiz do projeto da seguinte forma: 

KEY=SUA_KEY

Siga as instrucoes do package 

[dotenv](https://pub.dev/packages/dotenv)

E execute o projeto :)

```
$ dart run bin/server.dart
Server listening on port 8080
```