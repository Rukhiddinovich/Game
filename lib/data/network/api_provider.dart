import 'dart:convert';

import 'package:http/http.dart';

import '../../models/currency_model.dart';
import '../../models/universal_response.dart';
import 'package:http/http.dart' as http;

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
