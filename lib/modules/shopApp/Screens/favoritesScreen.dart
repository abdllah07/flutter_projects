import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstproje/models/shopApp/Favorites_model.dart';
import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
                context,
                ShopCubit.get(context).favorites_Model!.data!.data![index]
                    as FavoritesData?),
            separatorBuilder: (context, index) => SizedBox(
              height: 0,
            ),
            itemCount:
                ShopCubit.get(context).favorites_Model!.data!.data!.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

}
Widget buildFavItem(context, FavoritesData? model ) => Container(
  height: 130,
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.orange.shade100,
        blurRadius: 4,
        offset: Offset(4, 10), // Shadow position
      ),
    ],
  ),
  child: Padding(
    padding: EdgeInsets.all(5.0),
    child: GestureDetector(
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: "title",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(model!.product!.image!),
                    width: 130,
                    height: 130,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        model!.product!.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                        //TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ),
                    Text(
                      model!.product!.price!.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: false,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Container(
                      width: double.infinity,
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .ChangeFavorites(model.product!.id);
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                  .favorites[model!.product!.id]!
                                  ? Colors.red
                                  : Colors.grey,
                              radius: 15,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
      onTap: () {},
    ),
  ),
);
