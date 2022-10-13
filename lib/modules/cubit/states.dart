import 'package:shop_appliction/models/change%20model.dart';
import 'package:shop_appliction/models/login%20model.dart';

import '../../models/favourite model.dart';

abstract class Shopstates {}
class ShopInitialState extends Shopstates{}
class ShopChangeBottomNavState extends Shopstates{}
class ShopLoadingHomeDataState extends Shopstates{}
class ShopSucessHomeDataState extends Shopstates{}
class ShopErrorHomeDataState extends Shopstates{}
class ShopSucessCategoriesState extends Shopstates{}
class ShopErrorCategoriesState extends Shopstates{}
class ShopHomeChangeFavoriteSuccessState extends Shopstates {
  final ChangeFavoriteModel model;
  ShopHomeChangeFavoriteSuccessState(this.model);
}
class ShopHomeChangeFavoriteErrorState extends Shopstates {
  final ChangeFavoriteModel model;

  ShopHomeChangeFavoriteErrorState(this.model);
}
class ShopHomeChangeFavoriteState extends Shopstates {}
class ShopSucessGetfavouritesState extends Shopstates{}
class ShopErrorGetfavouritesState extends Shopstates{}
class ShopHomeGetFavoritesLoadingState extends Shopstates{}
class ShopSucessUserDataState extends Shopstates{
  final ShopLoginModel loginModel;
  ShopSucessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends Shopstates{}
class ShopLoadingUserDataState extends Shopstates{}
class ShopSuccessUpdateProfile extends Shopstates{
  // final ShopLoginModel loginModel;
  // ShopSuccessUpdateProfile(this.loginModel);
}
class ShopErrorUpdateProfile extends Shopstates{}
class ShopLoadingUpdateProfile extends Shopstates{}
