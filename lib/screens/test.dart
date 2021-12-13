import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
        child: Column(
          children: [
            TextField(
              decoration:
                  InputDecoration(hintText: 'Click me! to cause layout error'),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    await methodWithSuccess();
                    await methodWithError();
                  },
                  child: Text('Run Async operation')),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? Colors.blue.shade400
                        : Colors.grey.shade400,
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Item #${index + 1}'),
                  )),
                );
              },
              itemCount: 12,
            )
          ],
        ),
      ),
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
