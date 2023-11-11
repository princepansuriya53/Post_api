// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:post_api/changepass.dart';
import 'package:post_api/main.dart';

class forget extends StatefulWidget {
  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.mail_lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Email",
                  hintText: "Enter The email",
                ),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) => email = value,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () => forgetfun(),
              child: const Text("Forget Password"))
        ],
      ),
    );
  }

  void forgetfun() async {
    http.Response res = await Authorep.regsterapi(email: email);

    var reponse = jsonDecode(res.body);

    print('//$email');

    if (reponse["message"] == "Email ID is Right") {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(content: Text('${reponse["message"]}')),
          )
          .closed
          .then(
            (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => chnage(email: email)),
                (Route<dynamic> route) => false),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${reponse["message"]}')),
      );
    }
  }
}

class Authorep {
  static Future regsterapi({required email}) async {
    return await post(
      Uri.parse(APIurl.urlbase),
      body: {
        "action": "emailcheck",
        "email": "$email",
      },
    );
  }
}
