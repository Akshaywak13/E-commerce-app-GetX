import 'package:e_commerce_app/Constants/assets_image.dart';
import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/View/Screens/bottom_bar_tabs.dart';
import 'package:e_commerce_app/View/Singup_Screen/login_screen.dart';
import 'package:e_commerce_app/app_pref/app_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      AppPref().getUserToken().then((value){
        if(value==""){
          Get.offAll(()=>const LoginScreen());
        }else{
          Get.offAll(()=>const BottomBarTabs());
        }
      });
      Get.offAll(()=>const LoginScreen());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.splashscreenbgColor,
      body: Center(
        child: Image.asset(ImageAssets.splashScreenImage),
      ),
    );
  }
}