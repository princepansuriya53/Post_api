import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class kalam extends StatefulWidget {
  @override
  State<kalam> createState() => _kalamState();
}

class _kalamState extends State<kalam> {
  List user = [];
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  void fetchdata() async {
    String url =
        "https://www.skydigitalcard.com/kidsnursery/kalam.php?action=kalamlist";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var itam = jsonDecode(response.body)['Kalam'];

      print("\\\\${itam}");

      setState(() {
        user = itam;
      });
      print(1);
    } else {
      setState(() {
        user = [];
      });
      print(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalam'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 4,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: user.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: user[index]["Kalam_img"],
                  alignment: Alignment.center,
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 100, color: Colors.red),
                ),
              ),
              Text(
                user[index]["Kalam_id"].toString(),
                style:
                    const TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
