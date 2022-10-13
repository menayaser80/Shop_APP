import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/Popular%20Cubit/dio%20helper.dart';
import 'package:shop_appliction/models/categories%20model.dart';
import 'package:shop_appliction/models/change%20model.dart';
import 'package:shop_appliction/models/home%20model.dart';
import 'package:shop_appliction/models/login%20model.dart';
import 'package:shop_appliction/modules/categories.dart';
import 'package:shop_appliction/modules/cubit/states.dart';
import 'package:shop_appliction/modules/favourite.dart';
import 'package:shop_appliction/modules/products.dart';
import 'package:shop_appliction/modules/setting.dart';
import 'package:shop_appliction/shared/Constants.dart';
import 'package:shop_appliction/shared/end%20points.dart';

import '../../models/favourite model.dart';
class ShopCubit extends Cubit<Shopstates>
{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get (context)=>BlocProvider.of(context);
  int currentindex=0;
  List<Widget>BottomScreens=[
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];
  void changebottom(int index)
  {
    currentindex=index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel? homeModel;
  Map<int,bool>favourite={};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      // printFullText(homeModel!.data.banners[0].image);
      // print(homeModel!.status);
      homeModel!.data.products.forEach((element) {
        favourite.addAll({
          element.id:element.in_favorites,
        });
      });
      print(favourite.toString());
      emit(ShopSucessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel;
  void getcategories()
  {
    DioHelper.getData(
      url: Get_Categories,
      token:token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSucessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int? productId) {
    favourite[productId!] = !favourite[productId]!;
    emit(ShopHomeChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      if (!changeFavoriteModel!.status!) {
        favourite[productId] = !favourite[productId]!;
      } else {
        getFavourites();
      }
      emit(ShopHomeChangeFavoriteSuccessState(changeFavoriteModel!));
    }).catchError((error) {
      favourite[productId] = !favourite[productId]!;
      emit(ShopHomeChangeFavoriteErrorState(changeFavoriteModel!));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  FavouritesModel? favouritesModel;
  void getFavourites() {
    emit(ShopHomeGetFavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSucessGetfavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetfavouritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);
      emit(ShopSucessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateProfile({
    required String name,
    required String phone,
    required String email,
  })
  {
    emit(ShopLoadingUpdateProfile());
    DioHelper.putData(
      path: UPDATE,
      token: token,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateProfile());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(ShopErrorUpdateProfile());
    });
  }
}