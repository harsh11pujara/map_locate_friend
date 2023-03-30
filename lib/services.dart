import 'dart:convert';

import 'package:http/http.dart' as http;

class MapServices{

  getAutocorrectData(String searchText) async{
    String apiKey = 'AIzaSyDdfZW0c9OBwdTilbJJYDddYeOcO6snkcw';
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchText&types=geocode&key=$apiKey";
    var response = await http.get(Uri.parse(baseUrl));
    print("response" + response.toString());
    var decodedResponse = jsonDecode(response.body);
    var json = decodedResponse['predictions'] as List;
    print(json.toString());

  }
}