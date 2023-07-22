import 'package:bloc/bloc.dart';
import 'package:firstproje/layout/Home_layout.dart';
import 'package:firstproje/layout/newsApp/News_layout.dart';
import 'package:firstproje/layout/newsApp/cubit/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/shop_layout.dart';
import 'package:firstproje/modules/shopApp/login/loginScreen.dart';
import 'package:firstproje/modules/shopApp/shared/network/local/Shopcash_helper.dart';
import 'package:firstproje/modules/shopApp/shared/network/remote/shopDioHelper.dart';

import 'package:firstproje/modules/bmi/bmiScreen.dart';
import 'package:firstproje/modules/counter/counterScreen.dart';
import 'package:firstproje/modules/login/HomeScreen.dart';
import 'package:firstproje/modules/shopApp/onboarding/onBoardingScreen.dart';
import 'package:firstproje/shared/bloc_observer.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:firstproje/shared/cubit/cubit.dart';
import 'package:firstproje/shared/cubit/states.dart';
import 'package:firstproje/shared/network/local/cash_helper.dart';
import 'package:firstproje/shared/network/remote/dio_helper.dart';
import 'package:firstproje/shared/styles/Themses.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  shopDioHelper.init();
  await ShopCashHelper.init();
  bool? Onboarding = ShopCashHelper.getData(key: 'onBoarding');
  token = ShopCashHelper.getData(key: 'token');
  print(token);
  Widget widget;

  if (Onboarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  }else{
    widget = onBoardingScreen();
  }
  await CashHelper.init();
  runApp(MyApp( widget!));
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/ShopAppLogo.png"),
          ],
        ),
      ),
      nextScreen: onBoardingScreen(),
      splashIconSize: 550,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(seconds: 1),
    );
  }
}

class MyApp extends StatelessWidget {
  late final Widget startwidget;
  MyApp( this.startwidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(
          create: (context) => AppCubit()
        ),
        BlocProvider(
            create: (context) => ShopCubit()..getProductData()..getCategoriesData()..getFavoritesData()..getProfileData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startwidget,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme);
        },
      ),
    );
  }
}

class testScreen extends StatelessWidget {
  const testScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album, size: 45),
            title: Text('Sonu Nigam'),
            subtitle: Text('Best of Sonu Nigam Song'),
          ),
        ],
      ),
    );
  }
}
