// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/Advance_api.dart';
import 'package:post_api/forgetpass.dart';
import 'package:post_api/register.dart';
import 'kalam.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: homepage(),
      title: "API",
    );
  }
}

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String email = '';
  String pwd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API'),
        centerTitle: true,
      ),
      drawer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
          width: 250,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(150, 30)),
          ),
          child: Column(
            children: [
              const DrawerHeader(child: Text('Welcome')),
              ListTile(
                trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => regs()));
                    },
                    child: const Text('Registrion')),
                leading:
                    const Icon(Icons.note_alt_rounded, color: Colors.brown),
              ),
              ListTile(
                trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => forget()));
                    },
                    child: const Text('Forget Password')),
                leading: const Icon(Icons.lock_person_rounded,
                    color: Colors.redAccent),
              ),
              ListTile(
                trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => theapi()),
                      );
                    },
                    child: const Text('Api Data')),
                leading: const Icon(
                  Icons.data_array_sharp,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter the Email",
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  onChanged: (value) => pwd = value,
                  decoration: const InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Pwd",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: ElevatedButton(
                    onPressed: () {
                      loginfun();
                    },
                    child: const Text("Login")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginfun() async {
    http.Response res = await Authorepo.registerapi(email: email, pwd: pwd);

    var respone = jsonDecode(res.body);

    print('//$respone');

    if (respone["message"] == "Successfully Login") {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(content: Text('${respone["message"]}')),
          )
          .closed
          .then(
            (value) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => kalam())),
          );
      print(12);
    } else {
      print(34);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${respone["message"]}')),
      );
    }
  }
}

class APIurl {
  static String urlbase = "http://jojobazzar.com/foodapp/index.php";
}

class Authorepo {
  static Future registerapi(
      {required String email, required String pwd}) async {
    return post(
      Uri.parse(APIurl.urlbase),
      body: {
        'action': 'login',
        'email': email,
        'pwd': pwd,
      },
    );
  }
}
