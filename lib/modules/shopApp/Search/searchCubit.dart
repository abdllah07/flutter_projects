
import 'package:firstproje/models/shopApp/search_model.dart';
import 'package:firstproje/modules/shopApp/Search/searchStates.dart';
import 'package:firstproje/modules/shopApp/shared/network/end_points.dart';
import 'package:firstproje/modules/shopApp/shared/network/local/Shopcash_helper.dart';
import 'package:firstproje/modules/shopApp/shared/network/remote/shopDioHelper.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<ShopSearchStates>{
  SearchCubit ():super(ShopSearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

   Search_Model ?  model;


  void Search(String ? text )
  {

    emit(ShopSearchLoadingState());

    shopDioHelper.postData(url: SEARCH,
        token: token,
        data:
    {
      'text':text!,
    }).then((value) {

      model = Search_Model.fromJson(value.data);
      emit(ShopSearchSuccessState(model!));

    }).catchError((onError){
      print(onError.toString());
    emit(ShopSearchErrorState(onError));
    });
  }

}