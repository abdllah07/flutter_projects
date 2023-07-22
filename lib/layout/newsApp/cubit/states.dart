abstract class NewsState{}


class NewsInitialState extends NewsState{}

class NewBottomNavBarState extends NewsState{}

class NewsGetBusinessSuccessState extends NewsState{}


class NewsGetBusinessLoadingState extends NewsState{}


class NewsGetBusinessErrorState extends NewsState{
  late final String error;
  NewsGetBusinessErrorState(this.error);
}


class NewsGetSporsSuccessState extends NewsState{}


class NewsGetSporsLoadingState extends NewsState{}


class NewsGetSporsErrorState extends NewsState{
  late final String error;
  NewsGetSporsErrorState(this.error);
}


class NewsGetScineceSuccessState extends NewsState{}


class NewsGetScineceLoadingState extends NewsState{}


class NewsGetScineceErrorState extends NewsState{
  late final String error;
  NewsGetScineceErrorState(this.error);
}



class NewsGetSearchSuccessState extends NewsState{}


class NewsGetSearchLoadingState extends NewsState{}

class NewsGetSearchErrorState extends NewsState{
  late final String error;
  NewsGetSearchErrorState(this.error);
}