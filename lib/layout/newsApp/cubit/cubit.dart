import 'package:bloc/bloc.dart';
import 'package:firstproje/layout/newsApp/cubit/states.dart';
import 'package:firstproje/modules/newsApp/Settings/SettingsScreen.dart';
import 'package:firstproje/modules/newsApp/business/BusinessScreen.dart';
import 'package:firstproje/modules/newsApp/science/ScienceScreen.dart';
import 'package:firstproje/modules/newsApp/sports/SportsScreen.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:firstproje/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // start nav Bottom Nav bar
  List<BottomNavigationBarItem> bottomitems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1 ){getSpors();}
    if (index == 2 ){getScience();}
    emit(NewBottomNavBarState());
  }
// end nav Bottom Nav bar

// start Screens

  List<Widget> Screens = [
    BusinessScreen(),
    SportScreen(),
    ScineceScreen(),
    SettingsScreen(),
  ];

// end Screens




// get data from api

  List<dynamic> business = [];



  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'fd05944246e74278be31597c137d2c87',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sports = [];


  void getSpors()
  {
    emit(NewsGetSporsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'sports',
        'apiKey':'fd05944246e74278be31597c137d2c87',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(NewsGetSporsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSporsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getScience()
  {
    emit(NewsGetScineceLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'science',
        'apiKey':'fd05944246e74278be31597c137d2c87',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      print(science[0]['title']);

      emit(NewsGetScineceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScineceErrorState(error.toString()));
    });
  }



  List<dynamic> search = [];
  void getSearch(String value )
  {

    search = [];
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':'$value',
        'apiKey':'fd05944246e74278be31597c137d2c87',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }



}
