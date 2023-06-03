import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/utils/globalveriables.dart';

class MobilScreen extends StatefulWidget {
  const MobilScreen({super.key});

  @override
  State<MobilScreen> createState() => _MobilScreenState();
}

class _MobilScreenState extends State<MobilScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void jumpPage(int page){
    pageController.jumpToPage(page);
  }

  void navigate(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: navigate,
        children: pageChange,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: _page == 0 ? Colors.black : Colors.blueGrey),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: _page == 1 ? Colors.black : Colors.blueGrey),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _page == 2 ? Colors.black : Colors.blueGrey),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color: _page == 3 ? Colors.black : Colors.blueGrey),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: _page == 4 ? Colors.black : Colors.blueGrey),label: ""),
        ],
        onTap: jumpPage,
      ),
    );
  }
}