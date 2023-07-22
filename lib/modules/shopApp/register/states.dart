
import 'package:firstproje/models/shopApp/loginModel.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  final shopLoginModel ? RegisterModel;
  ShopRegisterSuccessState(this.RegisterModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  late final String error ;
  ShopRegisterErrorState(this.error);
}

