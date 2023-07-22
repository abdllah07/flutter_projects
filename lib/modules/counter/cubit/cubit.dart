import 'package:firstproje/modules/counter/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class counter_cubit extends Cubit<counter_states>
{
  counter_cubit() : super(CounterInitialState());

  static counter_cubit get(context) => BlocProvider.of(context);

  int counter = 1 ;


  void minus(){
    counter--;
    emit(CounterMinusState());
  }
  void plus(){
    counter++;
    emit(CounterPlusState());
  }
}