import 'package:firstproje/layout/newsApp/cubit/cubit.dart';
import 'package:firstproje/layout/newsApp/cubit/states.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsState>(
      listener: (context , state ) {} ,
      builder: (context , state) {
        var list =NewsCubit.get(context).sports;
        return articleBuilder(list,  context, state);
      },
    );
  }
}
