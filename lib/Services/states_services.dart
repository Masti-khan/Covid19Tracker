import 'dart:convert';

import 'package:covid_appdart/Models/world_states_model.dart';
import 'package:covid_appdart/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesrecords() async {
    try {
      final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

      if (response.statusCode == 200) {
        print('################The API is successfully integrated');
        var data = jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      } else {
        print('################The API isn\'t integrated');

        throw Exception('Error: failed to fetch data');
      }
    } catch (e) {
      print('####################  Exceptoin occours$e');
      rethrow;
    }
  }

  Future<List<dynamic>> countriesrecords() async {
    var data;
    try {
      final response = await http.get(Uri.parse(AppUrl.countriesList));

      if (response.statusCode == 200) {
        print('################The API is successfully integrated');
        data = jsonDecode(response.body);
        return data;
      } else {
        print('################The API isn\'t integrated');

        throw Exception('Error: failed to fetch data');
      }
    } catch (e) {
      print('####################  Exceptoin occours$e');
      rethrow;
    }
  }
}
