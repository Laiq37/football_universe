import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetWork{

  static dynamic fetchData(dynamic arg)async{
    //for matches
    //if wanted limited data then add this endpoint "/${arg[0]}.json?category_id=${arg[1]}&from=0&count=20&api_version=2""
    var response = await http.get(Uri.parse(
        arg)).timeout(const Duration(seconds: 20)).catchError((err){throw TimeoutException("");});
    return _processResponse(response);
  }

  static _processResponse(var response){
  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }
  throw Exception("failed to get response");
}
}