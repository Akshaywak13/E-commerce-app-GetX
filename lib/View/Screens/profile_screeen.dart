import 'package:e_commerce_app/Constants/app_style.dart';
import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/Constants/comman_tost.dart';
import 'package:e_commerce_app/Constants/loading_indicator.dart';
import 'package:e_commerce_app/Constants/text.dart';
import 'package:e_commerce_app/Models/user_detail_model.dart';
import 'package:e_commerce_app/api_services/api_services.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

UserDetailModel userDetailModel = UserDetailModel();
bool isLoading=false;
getUserDetail(){
  setState(() {
    isLoading=true;
  });

// user Id ????

  ApiServices().getUserDetail(1).then((value) {
    userDetailModel=value;

    setState(() {
      isLoading=false;
    });
    debugPrint(value.toString());

  }).onError((error, stackTrace) {
    debugPrint(error.toString());
    commonTost("Something went wrong");
  });
}

@override
  void initState() {
    UserDetailModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
        title: Text(AppText.Profiles,style: TextStyle(color: AppColors.whiteColor),),
      ),
      body: isLoading? Center(child: loadingIndicator(AppColors.pinkColor),):
      ListView(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        children: [
          Text(AppText.PersonalDetails,style: TextStyle(color: AppColors.blueColor,fontWeight:AppStyle.boldfont,fontSize: AppStyle.fo20),),

          Container(
            margin: const EdgeInsets.only(top: 8,bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.greyColor.withOpacity(.2)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               // Text("Name: ${userDetailModel.name!.firstname} ${userDetailModel.name!.lastname} ",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
                Text("Name: ${userDetailModel.name} ",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
                Text("Phone: ${userDetailModel.phone}",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
                 Text("Email: ${userDetailModel.email}",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
               
              ],
            ),
          ),
              Text(AppText.Address,style: TextStyle(color: AppColors.blueColor,fontWeight:AppStyle.boldfont,fontSize: AppStyle.fo20),),

          Container(
            margin: const EdgeInsets.only(top: 8,bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.greyColor.withOpacity(.2)
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text("City: ${userDetailModel.address!.city} ",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
                //Text("Street: ${userDetailModel.address!.street}",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
                 //Text("Zipcode: ${userDetailModel.address!.zipcode}",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
                //Text("lat: ${userDetailModel.address!.geolocation!.lat}",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
                // Text("long: ${userDetailModel.address!.geolocation!.long}",style:TextStyle(fontSize: AppStyle.fo18,fontWeight:AppStyle.w400font ),),
              ],
            ),
          ),
        ],
      )
    );
  }
}