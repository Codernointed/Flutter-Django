import 'package:flutter/material.dart';
import 'package:authenticate/auth_client.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authClient = AuthClient();

  String? _accessToken;

  @override
  void initState() {
    super.initState();
    _accessToken = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  _accessToken = await _authClient.login(
                      _emailController.text, _passwordController.text);
                } catch (e) {
                  print('Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login failed: ${e.toString()}'),
                    ),
                  );
                  return;
                }

                // Navigate to the next page
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
