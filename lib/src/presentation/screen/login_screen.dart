import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:barayafood/src/business_logic/provider/barayafood_provider.dart';
import 'package:barayafood/src/presentation/screen/register_screen.dart';
import 'package:barayafood/src/presentation/screen/home_screen.dart'; // Import HomeScreen
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<Map<String, dynamic>> _login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              child: Text('Login'),
              onPressed: () async {
                var username = _usernameController.text;
                var password = _passwordController.text;

                if (username.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Username and password are required!')),
                  );
                } else {
                  try {
                    final result = await _login(username, password);
                    print(
                        result); // Print the result for now, you can handle it as per your need

                    // Save the user_id and access_token in shared preferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setInt('user_id', result['user_id']);
                    await prefs.setString(
                        'access_token', result['access_token']);

                    // Navigate to HomeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } catch (e) {
                    print(
                        e); // Print the exception for now, you can handle it as per your need
                  }
                }
              },
            ),
            ElevatedButton(
              child: Text('Go to Register'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
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
