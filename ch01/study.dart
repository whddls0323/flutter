import 'dart:async';

import '11_future_async_await.dart';

Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 3), () {
    return "fetchData!";
  });
}

Stream<int> countStream() async* {
  for(int i=1;i<=5;i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  print('here...1');

  fetchData()
    .then((data) {
      print('here...2: $data');
  })
  .catchError((err) {
    print('here...3: $err');
  })
  .whenComplete(() {
    print('here...4 비동기 작업 완료');
  });

  print('here...5');

  print('async_await...1');

  try {
    String data = await fetchData();
    print('async_await...2: $data');
  } catch(e) {
    print('async_await...3: $e');
  } finally {
    print('async_await...4 비동기 작업 완료');
  }
  print('async_await...5');

  final controller = StreamController<String>();

  controller.stream
    .listen((data) {
      print('stream...1: $data');
  })
  .onError((err) {
    print('stream error');
  });

  controller.sink.add('hello');
  controller.sink.add('welcome');
  controller.sink.add('greeting');

  Stream<int> stream = countStream();

  await for(int number in stream) {
    print('스트림 데이터 수신: $number');
  }
}