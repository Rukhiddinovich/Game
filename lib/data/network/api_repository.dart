import 'package:login_screen_homework/data/network/api_provider.dart';
import 'package:login_screen_homework/models/currency_model.dart';
import 'package:login_screen_homework/models/universal_response.dart';

class CurrencyRepository {
  final ApiProvider apiProvider;
  CurrencyRepository({required this.apiProvider});

  Future<List<CurrencyModel>>fetchCurrencies()async{
    UniversalResponse universalResponse=await apiProvider.getAllCurrencies();
    if(universalResponse.error.isEmpty){
      return universalResponse.data as List<CurrencyModel>;
    }
    return [];
  }
}
