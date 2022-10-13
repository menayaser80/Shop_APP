import 'package:shop_appliction/models/login%20model.dart';
abstract class ShopRegisterStates{}
class InitialRegisterState extends ShopRegisterStates{}
class ChangePassRegisterState extends ShopRegisterStates{}
class LoadingRegisterState extends ShopRegisterStates{}
class SuccessRegisterState extends ShopRegisterStates{
  late final ShopLoginModel loginModel;
  SuccessRegisterState(this.loginModel);
}
class ErrorRegisterState extends ShopRegisterStates{
  late final String error;
  ErrorRegisterState(this.error);
}