import 'package:e_commerce_app/Constants/app_style.dart';
import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/Constants/comman_tost.dart';
import 'package:e_commerce_app/Constants/common_button.dart';
import 'package:e_commerce_app/Constants/loading_indicator.dart';
import 'package:e_commerce_app/Constants/text.dart';
import 'package:e_commerce_app/View/Screens/bottom_bar_tabs.dart';
import 'package:e_commerce_app/View/Singup_Screen/user_register.dart';
import 'package:e_commerce_app/api_services/api_services.dart';
import 'package:e_commerce_app/app_pref/app_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocuseNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier obsecurePassword = ValueNotifier(true);

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
        title: Text(
          AppText.loginText,
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppText.WelcomeText,
                  style: TextStyle(
                      fontSize: AppStyle.fo20, fontWeight: AppStyle.boldfont),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: usernameController,
                  focusNode: usernameFocuseNode,
                  decoration: const InputDecoration(
                    labelText: AppText.Usernamelabeltext,
                    hintText: AppText.Usernamehinttext,
                  ),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder(
                    valueListenable: obsecurePassword,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        obscureText: obsecurePassword.value,
                        decoration: InputDecoration(
                            labelText: AppText.passwordlabeltext,
                            hintText: AppText.passwordhinttext,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                obsecurePassword.value =
                                    !obsecurePassword.value;
                              },
                              child: obsecurePassword.value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            )),
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                CommonButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print("Validate");
                      setState(() {
                        isLoading = true;
                      });

                      ApiServices()
                          .userLogin(usernameController.text.toString(),
                              passwordController.text.toString())
                          .then((value) {
                        debugPrint(value.toString());
                        AppPref().setUserToken(value['token'].toString());
                        Get.offAll(() => const BottomBarTabs());

                        setState(() {
                          isLoading = false;
                        });
                      }).onError((error, stackTrace) {
                        setState(() {
                          isLoading = false;
                        });
                        debugPrint(error.toString());
                        commonTost(AppText.incurrectCredentioal);
                      });
                    }
                  },
                  child: isLoading
                      ? loadingIndicator(AppColors.whiteColor)
                      : const Text(AppText.LoginButtontext),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const UserRegister());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppText.NewuseraddText,
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: AppStyle.w400font,
                            fontSize: AppStyle.fo14),
                      ),
                      Text(
                        AppText.userRegisterText,
                        style: TextStyle(
                            color: AppColors.blueColor,
                            fontWeight: AppStyle.w400font,
                            fontSize: AppStyle.fo14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
