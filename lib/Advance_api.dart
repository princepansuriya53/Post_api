// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class theapi extends StatefulWidget {
//   @override
//   State<theapi> createState() => _theapiState();
// }

// class _theapiState extends State<theapi> {
//   List user = [];
//   @override
//   void initState() {
//     fetchdata();
//     super.initState();
//   }

//   void fetchdata() async {
//     var Url = "https://www.skydigitalcard.com/dailyposttest/data/home.php";
//     String token = "JuhGT6NjxKtg72fkdnVRKX8Qu8Q1BF";
//     var response = await http.post(
//       Uri.parse(Url),
//       body: {
//         "user_id": "5563",
//         "business_id": "201",
//       },
//       headers: {"Authorization": token},
//     );
//     var itam = jsonDecode(response.body)["HomeData"];

//     print("///$user");
//     if (response.statusCode == 200) {
//       setState(() {
//         user = itam;
//       });
//     } else {
//       setState(() {
//         user = [];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('APp'),
//       ),
//       body: ListView.builder(
//         itemCount: user.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Column(
//             children: [
//               for (var data in user[index]["UpcommingDays"]) ...[
//                 ListTile(
//                   title: Text(data["Dayname"]),
//                 ),
//                 Container(
//                   height: 150,
//                   width: 150,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                     fit: BoxFit.fill,
//                     filterQuality: FilterQuality.high,
//                     image: NetworkImage(data["postimg"]),
//                   )),
//                 ),
//               ],
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class theapi extends StatefulWidget {
  @override
  State<theapi> createState() => _theapiState();
}

class _theapiState extends State<theapi> {
  List user = [];
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  void fetchdata() async {
    var Url = "https://jsonplaceholder.typicode.com/posts";

    print(Url);
    // String token = "JuhGT6NjxKtg72fkdnVRKX8Qu8Q1BF";
    var response = await http.post(
      Uri.parse(Url),
      // body: {
      //   "user_id": "5563",
      //   "business_id": "201",
      // },
      // // headers: {"Authorization": token},
    );
    var itam = jsonDecode(response.body)
    ;

    print("///$itam");
    if (response.statusCode == 200) {
      setState(() {
        user = itam;
      });
    } else {
      setState(() {
        user = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APp'),
      ),
      body: ListView.builder(
        itemCount: user.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [Text(user[index]["id"])],
          );
        },
      ),
    );
  }
}
