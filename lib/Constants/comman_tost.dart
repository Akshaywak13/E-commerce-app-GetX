import 'package:e_commerce_app/Constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

commonTost (String message) {
  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        
        backgroundColor: AppColors.blackColor,
        textColor: AppColors.whiteColor,
        fontSize: 16.0
    );
}