import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:barayafood/src/business_logic/provider/barayafood_provider.dart';
import 'package:barayafood/src/presentation/screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<String> _register(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      var data = jsonDecode(response.body);
      return data['access_token'] ??
          ''; // return an empty string if 'access_token' is not present
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception(
          'Failed to register. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              child: Text('Register'),
              onPressed: () async {
                var username = _usernameController.text;
                var password = _passwordController.text;

                if (username.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                } else {
                  try {
                    final token = await _register(username, password);
                    print(
                        token); // Print the token for now, you can handle it as per your need

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Daftar berhasil')),
                    );

                    // Navigate to LoginScreen after registration
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false, // remove all previous routes
                    );
                  } catch (e) {
                    print(
                        e); // Print the exception for now, you can handle it as per your need
                  }
                }
              },
            ),
            ElevatedButton(
              child: Text('Go to Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
