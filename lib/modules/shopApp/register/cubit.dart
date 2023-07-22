
import 'package:bloc/bloc.dart';
import 'package:firstproje/modules/shopApp/login/states.dart';
import 'package:firstproje/modules/shopApp/register/states.dart';

import 'package:firstproje/modules/shopApp/shared/network/end_points.dart';
import 'package:firstproje/modules/shopApp/shared/network/remote/shopDioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shopApp/loginModel.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  shopLoginModel ? RegisterModel ;


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    shopDioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      print(value);
      RegisterModel = shopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(RegisterModel));
    }).catchError((onError) {
      print("errorrr ${onError.toString()}" );
      emit(ShopRegisterErrorState(onError.toString()));
    });
  }
}
