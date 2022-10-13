import 'package:shop_appliction/models/login%20model.dart';

abstract class ShopLoginStates
{
}
class ShopLoginInitialState extends ShopLoginStates
{}
class ShopLoginLoadingState extends ShopLoginStates
{}
class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);

}
class ShopLoginErrorState extends ShopLoginStates
{

  late final String error;
  ShopLoginErrorState(this.error);
}
class ShopchangePasswordState extends ShopLoginStates
{}