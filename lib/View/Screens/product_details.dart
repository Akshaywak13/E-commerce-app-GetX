import 'package:e_commerce_app/Constants/app_style.dart';
import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/Constants/comman_tost.dart';
import 'package:e_commerce_app/Constants/common_button.dart';
import 'package:e_commerce_app/Constants/loading_indicator.dart';
import 'package:e_commerce_app/Constants/razerpay_handler.dart';
import 'package:e_commerce_app/Constants/text.dart';
import 'package:e_commerce_app/Models/single_product.dart';
import 'package:e_commerce_app/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductDetails extends StatefulWidget {
  final int productId;
  final String productName;
  const ProductDetails({super.key, required this.productId, required this.productName});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  SingleProductModel singleProductModel = SingleProductModel();
  bool isLoading = false;
  getProducts() {
    setState(() {
      isLoading = true;
    });

    ApiServices().getSingleProduct(widget.productId).then((value) {
      singleProductModel = value;

      setState(() {
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      commonTost("Somthing wont wrong");
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.whiteColor),
        backgroundColor: AppColors.blueColor,
        title: Text(
          widget.productName,
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),

      body:isLoading?Center(child: loadingIndicator(AppColors.pinkColor),):
      ListView(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              
              image: DecorationImage(image: NetworkImage(singleProductModel.image.toString()))
            ),
          ),
          const Divider(),

          Text(singleProductModel.title.toString(),style: const TextStyle(fontSize: AppStyle.fo20,fontWeight: FontWeight.bold),),
          Text("Price :${singleProductModel.price.toString()}",style: TextStyle(fontSize: AppStyle.fo18,fontWeight: AppStyle.w500font),),
          Text("Price :${singleProductModel.price.toString()}",style: TextStyle(fontSize: AppStyle.fo18,fontWeight: AppStyle.w500font),),
          Text("Category :${singleProductModel.category.toString()}",style: TextStyle(fontSize: AppStyle.fo18,fontWeight: AppStyle.w500font),),
          const SizedBox(height: 20,),
          Text("Discription:\n${singleProductModel.description.toString()}",style: TextStyle(fontSize: AppStyle.fo14,fontWeight: AppStyle.w400font),),

        ],
      ),
      bottomSheet: Container(
        height: 80,
        padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
        width: double.infinity,
        child: CommonButton(
          height: 45,
          child:const Text(AppText.BUYNOW) ,
         onTap:(){
           Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_test_1DP5mmOlF5G5ag',
                    'amount': singleProductModel.price,
                    'name': 'Acme Corp.',
                    'description': singleProductModel.title,
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {
                      'contact': '8888888888',
                      'email': 'test@razorpay.com'
                    },
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccess);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWallet);
                  razorpay.open(options);
                              
         }),
      ),
    );
  }
}


// SingleProductModel singleProductModel =SingleProductModel();
// bool isLoading=false;
// getProducts(){
//   setState(() {
//     isLoading=true;
//   });

//   ApiServices().getSingleProduct(widget.productId).then((value) {

// singleProductModel=value;

// setState(() {
//   isLoading=false;
// });
// //Useing this statment print the value of console
// //debugPrint(value.toString());
//   }).onError((error, stackTrace) {
//     debugPrint(error.toString());
//     commonTost("Something went wrong");
//   });
// }
// @override
//   void initState() {
//     getProducts();
//     super.initState();
//   }