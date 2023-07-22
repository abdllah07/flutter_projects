import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstproje/models/shopApp/categoriesModel.dart';
import 'package:firstproje/models/shopApp/productModel.dart';
import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/states.dart';
import 'package:firstproje/modules/shopApp/shared/network/local/Shopcash_helper.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavoritesState){
          if(state.model.status)
          {
            ShowToast(
              text: state.model.message!,
              state: ToastStates.SUCCESS,

            );
          }else{
            ShowToast(
              text: state.model.message!,
              state: ToastStates.ERROR,

            );

          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).productModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => BuildProdcuts(
              ShopCubit.get(context).productModel,
              ShopCubit.get(context).categoriesModel , context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget BuildProdcuts(ProductModel? model, CategoriesModel? Catmodel ,  context) => Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CarouselSlider(
                  items: model!.data!.banners
                      .map(
                        (e) => Image(
                          image: NetworkImage("${e.image}"),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        BuildCategoryItem(Catmodel!.data!.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: Catmodel!.data!.data.length,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Products ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 2,
                    children: List.generate(
                      model!.data!.products.length,
                      (index) => BuildGridProduct(model!.data!.products[index] , context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget BuildCategoryItem(DataModel? model) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade100,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(.8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade100,
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
                width: 100,
                child: Text(
                  model!.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
    ),
  );

  Widget BuildGridProduct(productModel? model , context) => Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Card(
            color: Colors.grey.shade100,
            // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // Set the clip behavior of the card
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // Define the child widgets of the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model!.image),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (model!.discount != 0)
                      Container(
                        color: Colors.orange,
                        child: Text(
                          "DISCOUNT",
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ),
                  ],
                ),
                // Add a container with padding that contains the card's title, text, and buttons
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Display the card's title using a font size of 24 and a dark grey color
                      Text(
                        model!.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Add a space between the title and the text
                      Container(height: 10),
                      // Display the card's text using a font size of 15 and a light grey color
                      Row(
                        children: [
                          Text(
                            "${model!.price.round()} \$",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (model!.discount != 0)
                            Text(
                              "${model!.old_price.round()} \$",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                        ],
                      ),
                      // Add a row with two buttons spaced apart and aligned to the right side of the card
                      Row(
                        children: <Widget>[
                          // Add a spacer to push the buttons to the right side of the card
                          const Spacer(),
                          // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            child: const Text(
                              "SHARE",
                              style: TextStyle(color: Colors.orange),
                            ),
                            onPressed: () {},
                          ),
                          // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            child: const Text(
                              "EXPLORE",
                              style: TextStyle(color: Colors.orange),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Add a small space between the card and the next widget
                Container(height: 5),
              ],
            ),
          ),
          Container(
            child: IconButton(
              onPressed: () {
                print(model.id);
                ShopCubit.get(context).ChangeFavorites(model!.id);
              },
              icon: CircleAvatar(
                backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,
                radius: 15,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),

            ),
          )
        ],
      );
}
