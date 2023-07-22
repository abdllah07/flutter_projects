class favoritesModel
{
    late bool  status ;
    String ?  message ;


    favoritesModel.froJson(Map<String , dynamic> json)
    {
      status = json['status'];
      message = json['message'];
    }
}