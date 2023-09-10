import 'package:flutter/material.dart';
import 'package:uni/model/activityModel.dart';
import 'package:uni/model/fieldModel.dart';

class ActDetail extends StatefulWidget {
  final Activity singleActivity;
  const ActDetail({Key? key, required this.singleActivity}) : super(key: key);

  @override
  State<ActDetail> createState() => _ActDetailState();
}

class _ActDetailState extends State<ActDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Hero(
            tag: 'appBar', child: Image.asset("assets/uni.png", height: 70)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            height: size.height * 0.25,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage("assets/activity.jpg"),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.02),
                Text(
                  widget.singleActivity.actName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: size.height*0.02),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey[700], height: 1.5),
                ),
                SizedBox(height: size.height*0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Lloji:\n${widget.singleActivity.actType}",style: TextStyle(color: Colors.grey[800],fontSize: 16),),
                    Text("Fusha:\n${widget.singleActivity.actField}",style: TextStyle(color: Colors.grey[800],fontSize: 16)),
                  ],
                ),
                SizedBox(height: size.height*0.04),
                Center(
                  child: Column(
                    children: [
                      const Text("Data:"),
                      Text(widget.singleActivity.actDate),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
