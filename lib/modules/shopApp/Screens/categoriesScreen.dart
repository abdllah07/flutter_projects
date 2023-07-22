import 'package:firstproje/models/shopApp/categoriesModel.dart';
import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/states.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopLayoutStates>(
      listener:(context , state ){} ,
      builder: (context , state) {
        return  ListView.separated(
          itemBuilder: (context , index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context , index) => SizedBox(height: 0,),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel ? model )=> Container(
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Column(
      children: [

        Row(
          children: [
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade100,
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: NetworkImage(
                              model!.image),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          model.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),

                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.orange,
                      ),

                    ],
                  ),


                ],
              ),

            ),

          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}
