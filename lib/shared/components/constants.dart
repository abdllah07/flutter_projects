

//  https://newsapi.org/v2/everything?q=tesla&&apiKey=fd05944246e74278be31597c137d2c87


import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/shared/components/components.dart';

import '../../modules/shopApp/login/loginScreen.dart';
import '../../modules/shopApp/shared/network/local/Shopcash_helper.dart';

void signOut(context){
  ShopCashHelper.removeData(key: "token").then((value) {
    if(value){
      ShopCubit.get(context).currentIndex = 0 ;
      NavigateAndFinish(context, LoginScreen());
    }
  });
}

String ? token = '';