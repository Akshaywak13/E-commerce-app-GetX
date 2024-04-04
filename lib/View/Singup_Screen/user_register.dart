import 'package:e_commerce_app/Constants/colors.dart';
import 'package:e_commerce_app/Constants/comman_tost.dart';
import 'package:e_commerce_app/Constants/common_button.dart';
import 'package:e_commerce_app/Constants/loading_indicator.dart';
import 'package:e_commerce_app/Constants/text.dart';
import 'package:e_commerce_app/Models/user_register_model.dart';
import 'package:e_commerce_app/View/Screens/bottom_bar_tabs.dart';
import 'package:e_commerce_app/api_services/api_services.dart';
import 'package:e_commerce_app/app_pref/app_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocuseNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode cityFocuseNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
        leading: BackButton(color: AppColors.whiteColor),
        title: Text(
          AppText.RegisterText,
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                    labelText: AppText.emaillabelText,
                    hintText: AppText.emailhintText,
                  ),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(usernameFocuseNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppText.pleaseEnterEmail;
                    }
                    return null;
                  },
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
                      return AppText.pleaseEnterUsername;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  decoration: const InputDecoration(
                    labelText: AppText.passwordlabeltext,
                    hintText: AppText.passwordhinttext,
                  ),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(cityFocuseNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppText.pleaseEnterPassword;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: cityController,
                  focusNode: cityFocuseNode,
                  decoration: const InputDecoration(
                    labelText: AppText.citylabelText,
                    hintText: AppText.cityhintText,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppText.pleaseEnterCity;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      UserRegistrationModel userRegistrationModel =
                          UserRegistrationModel();
                      userRegistrationModel.email =
                          emailController.text.toString();
                      userRegistrationModel.username =
                          usernameController.text.toString();
                      userRegistrationModel.password =
                          passwordController.text.toString();
                      userRegistrationModel.address?.city =
                          cityController.text.toString();

                      // userRegistrationModel.name?.firstname = "Code";
                      // userRegistrationModel.name?.lastname = "Craft";
                      // userRegistrationModel.address?.street = "7835 new road";
                      // userRegistrationModel.address?.number = "3";
                      // userRegistrationModel.address?.zipcode = "12926-3874";
                      // userRegistrationModel.address?.geolocation?.lat =
                      //     "-37.3159";
                      // userRegistrationModel.address?.geolocation?.long =
                      //     "81.1496";
                      // userRegistrationModel.phone = "1-570-236-7033";

                      ApiServices()
                          .userRegister(userRegistrationModel)
                          .then((value) {
                        debugPrint(value.toString());

                        AppPref().setUserToken(value['id'].toString());

                        Get.offAll(() => const BottomBarTabs());

                        setState(() {
                          isLoading = false;
                        });
                      

                       commonTost("Registration Successfully");
                      }).onError((error, stackTrace) {
                        setState(() {
                          isLoading = false;
                        });
                        debugPrint(error.toString());
                        commonTost("Something went wrong");
                      });
                    }
                  },
                  child: isLoading
                      ? loadingIndicator(AppColors.pinkColor)
                      : const Text(AppText.RegisterText),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
