import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await methodWithSuccess();
                await methodWithError();
              },
              child: Text('Run Async operation'))),
    );
  }

  Future methodWithError() async {
    await Future.delayed(Duration(seconds: 2));

    throw Future.error('Error, I was meant to do this!');

    print('I will never be called!');
  }

  Future methodWithSuccess() async {
    await Future.delayed(Duration(seconds: 2));
    print('Method succeeded');
  }
}
