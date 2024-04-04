import 'dart:convert';

import 'package:e_commerce_app/Models/product_categories.dart';
import 'package:e_commerce_app/Models/product_model.dart';
import 'package:e_commerce_app/Models/single_product.dart';
import 'package:e_commerce_app/Models/user_detail_model.dart';
import 'package:e_commerce_app/Models/user_register_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String baseurl = "https://fakestoreapi.com";

//User Login API
  Future<dynamic> userLogin(String userName, String password) async {
    var response = await http.post(Uri.parse("$baseurl/auth/login"),
        body: {"username": userName, "password": password});
    if (response.statusCode == 200){
      //this Api are not A Model thro generate before write this code >
      return jsonDecode(response.body);
      
    }else {
      throw Exception("Login Api Error");
      
    }
  }


//User Register API
Future<dynamic>userRegister (UserRegistrationModel userRegistrationModel)async{
var response = await http.post(Uri.parse("$baseurl/users"),
body:jsonEncode(userRegistrationModel)
);
if(response.statusCode==200){
  //this Api are not A Model throu generete before write this code
  return jsonDecode(response.body);
}else{
  throw Exception("Login Api Error");
}

}
//All Product API
Future<List<ProductModel>> getAllProduct()async{
  var response=await http.get(Uri.parse("$baseurl/products"));
  if(response.statusCode==200){
    //the ProductModel is a List Type before writting this Code >
    return List<ProductModel>.from(jsonDecode(response.body).map((x)=>ProductModel.fromJson(x)));
  }else{
    throw Exception("Product post Api error");
  }
}


// Single ProductModel API
Future<SingleProductModel>getSingleProduct (int productId)async{
  var response = await http.get(Uri.parse("$baseurl/products/$productId"));
  if(response.statusCode==200){
    // the Single ProductModel is not a List bfore Write This Code >
    return SingleProductModel.fromJson(json.decode(response.body));
  }else{
    throw Exception("Single Product Api error");
  }
}

//All Api Categories 
Future<dynamic> getAllCategories()async {
var response= await http.get(Uri.parse("$baseurl/products/categories"));
if(response.statusCode==200){
  return jsonDecode(response.body);
}else{
  throw Exception(" Catagories Error");
}
}


// All Categories Api
Future<List<ProductCategoriesModel>> getCategoriesModel (String categoryName) async{
  var response = await http.get(Uri.parse("$baseurl/products/category/$categoryName"));
  if(response.statusCode==200){
    return List<ProductCategoriesModel>.from(jsonDecode(response.body).map((x)=>ProductCategoriesModel.fromJson(x)));

  }else{
    throw Exception(" Categories Chooise Api Error");
  }
}



Future<UserDetailModel> getUserDetail (int userId)async{
var response = await http.get(Uri.parse("https://fakestoreapi.com/users/1"));
if(response.statusCode==200){
  return UserDetailModel.fromJson(json.decode(response.body));
}else{
  throw Exception("User Details Api Error");
}
}






}
