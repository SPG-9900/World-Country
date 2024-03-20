import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:world_country/model/country_model.dart';

class CountryService {
  Future<List<Country>> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> countriesJson = jsonDecode(response.body);
      return countriesJson.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
