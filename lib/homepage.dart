import 'package:flutter/material.dart';
import 'package:recipe_book/favoritepage.dart';
import 'package:recipe_book/home_details.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentpage=0;
  List<Widget> pages=[HomeDetails(),Favoritepage()];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: IndexedStack(
        index: currentpage,children: pages,
      ),
        bottomNavigationBar:BottomNavigationBar(
          iconSize: 35,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          onTap: (value){
            setState(() {
              currentpage=value;
            });
          },
          currentIndex: currentpage,
          items:
          [
            BottomNavigationBarItem
            (icon: Icon(Icons.home,
            color: currentpage==0?Colors.lightGreen:Colors.blueGrey,),
            label: ''),
            BottomNavigationBarItem
            (icon: Icon(Icons.favorite,
            color: currentpage==1?Colors.redAccent:Colors.blueGrey,),
            label: '')
          ] ) ,
      );
  }
}

