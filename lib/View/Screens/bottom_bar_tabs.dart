
import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/View/Screens/category_screen.dart';
import 'package:e_commerce_app/View/Screens/home_screen.dart';
import 'package:e_commerce_app/View/Screens/profile_screeen.dart';
import 'package:flutter/material.dart';


class BottomBarTabs extends StatefulWidget {
  const BottomBarTabs({super.key});

  @override
  State<BottomBarTabs> createState() => _BottomBarTabsState();
}

class _BottomBarTabsState extends State<BottomBarTabs> {

int _selectedIndex=0;
static final List<Widget> _widgetOptions=[
const HomeScreen(),
const CategoryScreen(),
const ProfileScreen(),
];

void _onItemTapped(int index){
  setState(() {
    _selectedIndex= index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  body: _widgetOptions[_selectedIndex],
    //Bottom tab ekda Api lod zali tr TAb change kele tri parat parat loding nahi honar >
body: IndexedStack(
  index: _selectedIndex,
  children:_widgetOptions,
),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.whiteColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home,color: AppColors.blueColor,),
          label: "Home"
          ),
           BottomNavigationBarItem(
          icon: const Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category,color: AppColors.blueColor,),
          label: "Categaries"
          ),
           BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline_sharp),
          activeIcon: Icon(Icons.person,color: AppColors.blueColor,),
          label: "Profile"
          ),
      ]),
    );
  }
}
