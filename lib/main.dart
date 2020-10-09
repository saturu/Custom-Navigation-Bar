import 'package:flutter/material.dart';

import 'custom_navigation_bar/custom_navigation_bar.dart';
import 'custom_navigation_bar/custom_navigation_bar_item.dart';

void main(){
  runApp(MaterialApp(home: MyAppTest()));
}

class MyAppTest extends StatefulWidget {
  @override
  _MyAppTestState createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest> {
  var key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        backgroundColor: Colors.black54,

        bottomNavigationBar: CustomNavigationBar(context, [
          CustomNavigationBarItem(icon: Icons.home,title: "Home"),
          CustomNavigationBarItem(icon: Icons.store,title: "Store",
              function: ()=>key.currentState.showSnackBar(SnackBar(content: Text("Hi")))),
          CustomNavigationBarItem(icon: Icons.explore,title: "Explore"),
          CustomNavigationBarItem(icon: Icons.supervised_user_circle,title: "Profile"),
        ],
          onChanged: (i){
            print("Item Change $i ");
          },
        )
    );
  }
}
