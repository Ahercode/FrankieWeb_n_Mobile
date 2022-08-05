// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/Material.dart';
// import 'package:frankie_s/API/apis.dart';
// import '../Widget/optionButtons.dart';

// class Tables extends StatefulWidget {
//   Tables({Key? key}) : super(key: key);

//   @override
//   State<Tables> createState() => _TablesState();
// }

// class _TablesState extends State<Tables> {
//   getTables() async {
//     var url = Uri.parse('$baseUrl/api/Tables');
//     var response =
//         await http.get(url, headers: {"Content-Type": "application/json"});
//     return jsonDecode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Container(
//             width: size.width,
//             height: size.height, // * 0.85,
//             color: Colors.white.withOpacity(0.9),
//             child: FutureBuilder(
//                 future: getTables(),
//                 builder: (context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasData) {
//                     return GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 6,
//                             crossAxisSpacing: 4.0,
//                             mainAxisSpacing: 4.0,
//                             childAspectRatio: 2.0),
//                         itemCount: snapshot.data.length,
//                         //widget.numberOfTables == 0? null: widget.numberOfTables,
//                         itemBuilder: (BuildContext context, index) {
//                           return SystemOptionButton().optionButton(
//                             context,
//                             "Table",
//                             //snapshot.data["Name"],
//                             snapshot.data["data"][index]["name"],
//                           );
//                         });
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 })));
//   }
// }
