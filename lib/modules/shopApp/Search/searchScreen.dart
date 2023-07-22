import 'package:firstproje/models/shopApp/Favorites_model.dart';
import 'package:firstproje/modules/shopApp/Screens/favoritesScreen.dart';
import 'package:firstproje/modules/shopApp/Search/searchCubit.dart';
import 'package:firstproje/modules/shopApp/Search/searchStates.dart';
import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchScreen extends StatelessWidget {
    var formKey = GlobalKey<FormState>();
    var SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context ) => SearchCubit(),
      
      child: BlocConsumer<SearchCubit , ShopSearchStates>(
        listener: (context ,state  ){},
        builder: (context , state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                      controller:SearchController ,
                      type: TextInputType.text,
                      validate: (value){
                        if(value.isEmpty){
                          return "Title must be not empty ! ";
                        }
                        return null ;
                      },
                      onsubmit: (String text){
                        SearchCubit.get(context).Search(text);
                      },
                      label: "Search",
                      iconP: Icons.search,
                  ),
                  SizedBox(height: 10,),
                  if(state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                  if(state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                      itemBuilder: (context, index) => buildFavItem(  context,
                          ShopCubit.get(context).favorites_Model!.data!.data![index]
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 0,
                      ),
                      itemCount:
                      SearchCubit.get(context).model!.data!.data!.length,
                    ),
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }


}
