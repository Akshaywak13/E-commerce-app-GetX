import 'package:e_commerce_app/Constants/app_style.dart';
import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/Constants/comman_tost.dart';
import 'package:e_commerce_app/Constants/common_button.dart';
import 'package:e_commerce_app/Constants/loading_indicator.dart';
import 'package:e_commerce_app/Constants/razerpay_handler.dart';
import 'package:e_commerce_app/Constants/text.dart';
import 'package:e_commerce_app/Models/product_categories.dart';
import 'package:e_commerce_app/View/Screens/product_details.dart';
import 'package:e_commerce_app/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductCategory extends StatefulWidget {
  final String categoryName;
  const ProductCategory({super.key, required this.categoryName});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {

List<ProductCategoriesModel> productCategoriesModel =[];
bool isLoading=false;
getCategoriesModel(){
  setState(() {
    isLoading=true;
  });

  ApiServices().getCategoriesModel(widget.categoryName).then((value) {

    productCategoriesModel=value;

    setState(() {
      isLoading=false;
    });
    debugPrint(value.toString());

  }).onError((error, stackTrace)  {
    debugPrint(error.toString());
    commonTost("Something went wrong");
  });
}
@override
  void initState() {
    getCategoriesModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
        leading: BackButton(color: AppColors.whiteColor,),
        title: Text(
          widget.categoryName,
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: isLoading
          ? Center(
              child: loadingIndicator(
                AppColors.pinkColor,
              ),
            )
          : ListView.separated(
              itemCount: productCategoriesModel.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              separatorBuilder: (context, i) => const SizedBox(
                    height: 8,
                  ),
              itemBuilder: (context, index) {
                final data = productCategoriesModel[index];
                return GestureDetector(
                  onTap: (){
                    Get.to(()=>ProductDetails(productId:data.id!, productName:data.title.toString()));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor,
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            NetworkImage(data.image.toString()))),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.title.toString(),
                                      style: TextStyle(
                                          fontSize: AppStyle.fo18,
                                          fontWeight: AppStyle.w500font),
                                    ),
                                    Text(
                                      "Price :${data.price.toString()}",
                                      style: TextStyle(
                                          fontSize: AppStyle.fo16,
                                          fontWeight: AppStyle.w400font),
                                    ),
                                    Text(
                                      "Ratting :${data.rating!.rate.toString()}",
                                      style: TextStyle(
                                          fontSize: AppStyle.fo16,
                                          fontWeight: AppStyle.w400font),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                          child: Text(
                            data.description.toString(),
                            style: TextStyle(
                                fontSize: AppStyle.fo14,
                                fontWeight: AppStyle.w400font),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                          child: CommonButton(
                              bgColor: AppColors.blueColor,
                              height: 45,
                              child: const Text(AppText.BUYNOW),
                              onTap: () {
                                 Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_test_1DP5mmOlF5G5ag',
                    'amount': data.price,
                    'name': 'Acme Corp.',
                    'description': data.title,
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
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}