
import 'package:firstproje/models/shopApp/search_model.dart';

abstract class ShopSearchStates{}

class ShopSearchInitialState extends ShopSearchStates{}
class ShopSearchLoadingState extends ShopSearchStates{}
class ShopSearchSuccessState extends ShopSearchStates{
  final Search_Model ? model;
  ShopSearchSuccessState(this.model);
}
class ShopSearchErrorState extends ShopSearchStates{
  late final String error ;
  ShopSearchErrorState(this.error);
}
