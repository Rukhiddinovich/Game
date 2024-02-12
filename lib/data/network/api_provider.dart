import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_screen_homework/models/currency_model.dart';
import 'package:login_screen_homework/models/universal_response.dart';

class ApiProvider {
   Future<UniversalResponse> getAllCurrencies() async {
    Uri uri = Uri.parse("https://www.freetogame.com/api/games");

    try {
      http.Response response = await http.get(uri);
      return UniversalResponse(

          data: (jsonDecode(response.body) as List?)
              ?.map((e) => CurrencyModel.fromJson(e))
              .toList() ??
              []);
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }
}
