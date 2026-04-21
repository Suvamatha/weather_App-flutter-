import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "4d84d99f6464f76073c3a37c3f29ed07";
  Future<Map<String, dynamic>> getWeather(String city)async{
    final url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return jsonDecode(response.body);

    }else{
      throw Exception("Failed to load weather data");
    }
  }
}