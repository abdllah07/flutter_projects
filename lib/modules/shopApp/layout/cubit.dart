import 'package:bloc/bloc.dart';
import 'package:firstproje/models/shopApp/Favorites_model.dart';
import 'package:firstproje/models/shopApp/categoriesModel.dart';
import 'package:firstproje/models/shopApp/loginModel.dart';
import 'package:firstproje/models/shopApp/productModel.dart';
import 'package:firstproje/models/user/user_model.dart';
import 'package:firstproje/modules/newsApp/Settings/SettingsScreen.dart';
import 'package:firstproje/modules/shopApp/Screens/categoriesScreen.dart';
import 'package:firstproje/modules/shopApp/Screens/favoritesScreen.dart';
import 'package:firstproje/modules/shopApp/Screens/productsScreen.dart';
import 'package:firstproje/modules/shopApp/Screens/settings.dart';
import 'package:firstproje/modules/shopApp/layout/states.dart';
import 'package:firstproje/modules/shopApp/shared/network/end_points.dart';
import 'package:firstproje/modules/shopApp/shared/network/remote/shopDioHelper.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:firstproje/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopApp/favoritesModel.dart';

class ShopCubit extends Cubit<ShopLayoutStates> {
  ShopCubit() : super(ShopLayoutInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ShopSettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  ProductModel? productModel;
  Map<int, bool> favorites = {};

  void getProductData() {
    emit(ShopLoadingProductDataState());

    shopDioHelper.getData(url: Home, token: token).then((value) {
      productModel = ProductModel.fromJson(value.data);
      productModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.in_favorites!,
        });
      });
      print(favorites.toString());

      emit(ShopSuccessProductDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorProductDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    shopDioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  favoritesModel? changeFavoriteModel;
  void ChangeFavorites(int? productId) {
    favorites[productId!] = !favorites[productId]!;

    emit(ShopSuccessFavoriteschangeState());

    shopDioHelper
        .postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    )
        .then((value) {
      changeFavoriteModel = favoritesModel.froJson(value.data);
      if (!changeFavoriteModel!.status) {
        favorites[productId!] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }

      emit(ShopSuccessFavoritesState(changeFavoriteModel!));
    }).catchError((onError) {
      favorites[productId!] = !favorites[productId]!;
      emit(ShopErrorFavoritesState());
    });
  }

  // Favorites
  Favorites_Model? favorites_Model;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());

    shopDioHelper.getData(url: FAVORITES, token: token).then((value) {
      favorites_Model = Favorites_Model.fromJson(value.data);

      emit(ShopSuccessGetFavoritesChangeState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

//Settings

  shopLoginModel ? userModel;

  void getProfileData() {
    emit(ProfileLoadingState());

    shopDioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = shopLoginModel.fromJson(value.data);

      emit(ProfileSuccessState(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ProfileErrorState());
    });
  }




  void getUpdateProfileData({
    required String name,
    required String email ,
    required String phone ,
  })

  {
    emit(UpdateProfileLoadingState());

    shopDioHelper.putData(url: UPDATE_PROFILE, token: token ,
    data:{
      'name':name ,
      'email':email,
      'phone':phone
    }
    ).then((value) {
      userModel = shopLoginModel.fromJson(value.data);

      emit(UpdateProfileSuccessState(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateProfileErrorState());
    });
  }

}
