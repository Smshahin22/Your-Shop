import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_shop/const/AppColors.dart';
import 'package:your_shop/ui/bottom_nav_pages/favourite.dart';
import 'package:your_shop/ui/bottom_nav_pages/home.dart';
import 'package:your_shop/ui/bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages = [HomeScreen(), Favourite(), Card(), Profile()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shop',style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60.h,
        centerTitle: true,
        automaticallyImplyLeading: false,


      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        selectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Home', backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourite', backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart', backgroundColor: Colors.teal),
          BottomNavigationBarItem(icon: Icon(Icons.person_off),label: 'Profile', backgroundColor: Colors.black),

        ],
        onTap: (index){
          setState(() {
            _currentIndex =index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
