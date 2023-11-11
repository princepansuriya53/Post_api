import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/main.dart';

class chnage extends StatefulWidget {
  String email;
  chnage({Key? key, required this.email});

  @override
  State<chnage> createState() => _chnageState();
}

class _chnageState extends State<chnage> {
  String email = '';
  String pwd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Enter the Password",
                  border: OutlineInputBorder(),
                  enabled: true,
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter the Conform Password",
                  border: OutlineInputBorder(),
                  enabled: true,
                ),
                onChanged: (value) {
                  pwd = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                funchp();
              },
              child: const Text('Change Password'),
            )
          ],
        ),
      ),
    );
  }

  void funchp() async {
    http.Response res =
        await authorepo.forgetapi(email: widget.email, pwd: pwd);
    var response = jsonDecode(res.body);
    if (response["message"] == "Password Change Successfully") {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(content: Text('${response["message"]}')),
          )
          .closed
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => homepage(),
              ),
              (route) => false));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response["message"]}')),
      );
    }
  }
}

class authorepo {
  static Future forgetapi({required email, required pwd}) async {
    return await post(
      Uri.parse(APIurl.urlbase),
      body: {
        "action": "changpwd",
        "email": "$email",
        "pwd": "$pwd",
      },
    );
  }
}
