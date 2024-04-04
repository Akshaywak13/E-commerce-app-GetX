import 'package:e_commerce_app/Constants/colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? bgColor;
  final double? height;
  const CommonButton({super.key, required this.child, required this.onTap, this.bgColor, this.height});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
                height: height?? 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.whiteColor,
                        backgroundColor: bgColor?? AppColors.blueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed:onTap,
                    child: child),
              );
  }
}