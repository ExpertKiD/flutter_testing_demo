import 'package:flutter/material.dart';
import 'package:testingdemo/services/login_service.dart';

class TestScreen extends StatelessWidget {
  LoginService loginService;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  TestScreen({
    Key? key,
    required this.loginService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: 'Click me! to cause layout error'),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await methodWithSuccess();
                      await methodWithError();
                    },
                    child: Text('Run Async operation')),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Username'),
                key: Key('txt_username'),
                controller: usernameController,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Password'),
                key: Key('txt_password'),
                controller: passwordController,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final username = usernameController.text;
                    final password = passwordController.text;

                    if (await loginService.loginWithUsernameAndPassword(
                        username, password)) {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            key: const Key('alert_login_success'),
                            title: const Text(
                                'You have been logged in successfully'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Ok'),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Falied to login'),
                        action: SnackBarAction(
                          key: Key('snack_login_failed'),
                          onPressed: () {},
                          label: 'Retry',
                        ),
                      ));
                    }
                  },
                  child: Text('Login'),
                  key: Key('btn_login'),
                ),
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
                itemCount: 8,
              )
            ],
          ),
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
