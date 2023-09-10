import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uni/home/fairDetail.dart';

import '../../model/fairModel.dart';


class Fairs extends StatefulWidget {
  const Fairs({Key? key}) : super(key: key);

  @override
  State<Fairs> createState() => _FairsState();
}

class _FairsState extends State<Fairs> {


  List<Fair> fairItems = [];

  getFairs() async {
    try {
      final response = await http.get(Uri.parse("http://localhost:6000/panair"),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body)['panaire'];
        List<Fair> fairs =
        responseBody.map<Fair>((json) => Fair.fromJson(json)).toList();
        setState(() {
          fairItems = fairs;
        });
        print("==============");
      } else if (response.statusCode == 400) {
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    getFairs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Image.asset("assets/uni.png", height: 70),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView(
       children: [
         SizedBox(height: size.height * 0.05),
         const Padding(
           padding: EdgeInsets.symmetric(horizontal: 10),
           child: Text(
             "Panairet",
             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
           ),
         ),
         SizedBox(height: size.height * 0.01),
         SizedBox(
           width: size.width,
           child: ListView.builder(
             physics: const NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             scrollDirection: Axis.vertical,
             itemCount: fairItems.length,
             itemBuilder: (BuildContext context, int index) {
               return GestureDetector(
                 onTap: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (_) =>
                               FairDetail(signleFair: fairItems[index])));
                 },
                 child: Container(
                   width: size.width * 0.95,
                   height: size.height * 0.25,
                   margin: const EdgeInsets.symmetric(
                       horizontal: 10, vertical: 10),
                   decoration: BoxDecoration(
                       color: Colors.blueGrey,
                       borderRadius: BorderRadius.circular(10),
                       image: DecorationImage(
                         image: const AssetImage("assets/panaire.jpeg"),
                         fit: BoxFit.cover,
                         colorFilter: ColorFilter.mode(
                             Colors.black.withOpacity(0.8), BlendMode.darken),
                       )),
                   child: Center(
                     child: Text(
                       fairItems[index].title.toString(),
                       style: const TextStyle(
                           color: Colors.white,
                           fontSize: 20,
                           fontWeight: FontWeight.w600),
                       maxLines: 2,
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                     ),
                   ),
                 ),
               );
             },
           ),
         ),
       ],
     ),
    );
  }
}
