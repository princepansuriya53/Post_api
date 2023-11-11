// ignore_for_file: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'main.dart';

class regs extends StatefulWidget {
  @override
  State<regs> createState() => _regsState();
}

class _regsState extends State<regs> {
  String firstname = '';
  String lastname = "";
  String address = "";
  String mobileno = '';
  String email = "";
  String pwd = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "First Name"),
                  onChanged: (value) => firstname = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Last Name",
                  ),
                  onChanged: (value) => lastname = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contact",
                  ),
                  onChanged: (value) => mobileno = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Address",
                  ),
                  onChanged: (value) => address = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mail",
                  ),
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  onChanged: (value) => pwd = value,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          funreg();
        },
        child: const Icon(Icons.app_registration_rounded,
            size: 45, color: Colors.black),
      ),
    );
  }

  void funreg() async {
    http.Response res = await Authorepo.registerapi(
        firstname: firstname,
        lastname: lastname,
        address: address,
        mobileno: mobileno,
        email: email,
        pwd: pwd);

    var response = jsonDecode(res.body);
    print("///${res}");

    print("///${response}");

    if (response["message"] == "Successfully Register") {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(content: Text('${response["message"]}')),
          )
          .closed
          .then(
            (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => homepage()),
                (Route<dynamic> route) => true),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response["message"]}')),
      );
    }
  }
}

class Authorepo {
  static Future registerapi({
    required firstname,
    required lastname,
    required address,
    required mobileno,
    required email,
    required pwd,
  }) async {
    return await post(
      Uri.parse(APIurl.urlbase),
      body: {
        'action': 'register',
        'firstname': '$firstname',
        "lastname": '$lastname',
        "address": '$address',
        "mobileno": '$mobileno',
        "email": "$email",
        'pwd': '$pwd',
      },
    );
  }
}
