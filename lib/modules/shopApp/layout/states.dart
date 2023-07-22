
import 'package:firstproje/models/shopApp/favoritesModel.dart';
import 'package:firstproje/models/shopApp/loginModel.dart';
import 'package:firstproje/models/user/user_model.dart';

abstract class ShopLayoutStates{}


class ShopLayoutInitialState extends ShopLayoutStates{}
class ShopChangeBottomNavState extends ShopLayoutStates{}

class ShopLoadingProductDataState extends ShopLayoutStates{}
class ShopSuccessProductDataState extends ShopLayoutStates{}
class ShopErrorProductDataState extends ShopLayoutStates{}

class ShopLoadingCategoriesDataState extends ShopLayoutStates{}
class ShopSuccessCategoriesState extends ShopLayoutStates{}
class ShopErrorCategoriesState extends ShopLayoutStates{}

class ShopSuccessFavoritesState extends ShopLayoutStates{
  final favoritesModel  model ;

  ShopSuccessFavoritesState(this.model);
}
class ShopErrorFavoritesState extends ShopLayoutStates{}
class ShopSuccessFavoriteschangeState extends ShopLayoutStates{}

class ShopLoadingGetFavoritesState extends ShopLayoutStates{}
class ShopErrorGetFavoritesState extends ShopLayoutStates{}
class ShopSuccessGetFavoritesChangeState extends ShopLayoutStates{}


class ProfileSuccessState extends ShopLayoutStates{
  final shopLoginModel loginModel;

  ProfileSuccessState(this.loginModel);
}
class ProfileErrorState extends ShopLayoutStates{}
class ProfileLoadingState extends ShopLayoutStates{}


class UpdateProfileSuccessState extends ShopLayoutStates{
  final shopLoginModel loginModel;

  UpdateProfileSuccessState(this.loginModel);
}
class UpdateProfileErrorState extends ShopLayoutStates{}
class UpdateProfileLoadingState extends ShopLayoutStates{}