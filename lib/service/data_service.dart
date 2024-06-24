
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stage/service/country.dart';

Future<List<Country>> fetchCountry() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((country) => Country.fromJson(country)).toList();
    } else{
      throw Exception('Failed to load countries');
    }

}
Future<Country> fetchCountryById(String id) async {
  final response = await http.get(Uri.parse('https://restcountries.com/v3.1/alpha/$id'));

  if (response.statusCode == 200) {
    return Country.fromJson(jsonDecode(response.body)[0]);
  } else {
    throw Exception('Failed to load country');
  }
}