import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/Constants/comman_tost.dart';
import 'package:e_commerce_app/Constants/loading_indicator.dart';
import 'package:e_commerce_app/Constants/text.dart';
import 'package:e_commerce_app/View/Screens/product_category.dart';
import 'package:e_commerce_app/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

bool isLoading=false;
dynamic categories;
getAllCategories(){
setState(() {
  isLoading=true;
});

ApiServices().getAllCategories().then((value) {
categories=value;

setState(() {
  isLoading=false;
});
//debugPrint(value.toString());

}).onError((error, stackTrace) {
  debugPrint(error.toString());
  commonTost("Somethin went Wrong");
});
}
@override
  void initState() {
    getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
       // leading: BackButton(color: AppColors.whiteColor,),
        title: Text(AppText.Categerys,style: TextStyle(color: AppColors.whiteColor),),
      ),
      body: isLoading?Center(child:loadingIndicator(AppColors.pinkColor) ,):
      ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context,index)=>const Divider(),
        itemBuilder: (context,index){
          return ListTile(
            onTap: (){
              Get.to(()=>ProductCategory(categoryName:categories[index].toString()));
            },
            leading: CircleAvatar(
              child: Text("${index+1}"),
            ),
            title: Text(categories[index].toString()),
          );
        } ),
    );
  }
}