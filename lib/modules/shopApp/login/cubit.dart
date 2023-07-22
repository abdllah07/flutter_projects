
import 'package:bloc/bloc.dart';
import 'package:firstproje/modules/shopApp/login/states.dart';
import 'package:firstproje/modules/shopApp/shared/network/end_points.dart';
import 'package:firstproje/modules/shopApp/shared/network/remote/shopDioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopApp/loginModel.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  shopLoginModel ? loginModel ;


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    shopDioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value);
      loginModel = shopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((onError) {
      print("errorrr ${onError.toString()}" );
      emit(ShopLoginErrorState(onError.toString()));
    });
  }
}
