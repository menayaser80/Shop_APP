import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/Popular%20Cubit/dio%20helper.dart';
import 'package:shop_appliction/Register/states.dart';
import 'package:shop_appliction/models/login%20model.dart';
import 'package:shop_appliction/shared/end%20points.dart';
class ShopCubitRegister extends Cubit<ShopRegisterStates>
{
  ShopCubitRegister() : super(InitialRegisterState());
  static ShopCubitRegister get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  bool ispass = true;
  IconData suffix = Icons.visibility;
  void changePass() {
    if (ispass == false) {
      ispass = true;
      suffix = Icons.visibility;
    }
    else {
      ispass = false;
      suffix = Icons.visibility_off;
    }
    emit(ChangePassRegisterState());
  }
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(LoadingRegisterState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(SuccessRegisterState(loginModel!));
    }).catchError((error){
      emit(ErrorRegisterState(error.toString()));
      print('error is ${error.toString()}');
    });
  }
}