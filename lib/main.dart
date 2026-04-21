import 'package:flutter/material.dart';
import 'package:weather_app/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController controller = TextEditingController();
  final WeatherService service = WeatherService();

  String city = "";
  String temp ="";
  String desc = "";
  bool loading = false;
  String error = "";

  void fetchWeather()async{
    setState(() {
      loading = true;
      error = "";
    });

    try{
      final data = await service.getWeather(controller.text);

      setState(() {
        city = data["name"];
        temp = data["main"]["temp"].toString();
        desc = data["weather"][0]["description"];
        loading = false;
      });
    } catch(e){
      setState(() {
        error = "City Not Found";
        loading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Weather of Today'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter the name of City',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10,),

            //Button 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {
                  fetchWeather()
                },
                child: Text('Get Weather'),
              ),
            ),

            SizedBox(height: 30,),

            if(loading)
              CircularProgressIndicator()
            else if (city.isNotEmpty)
              Text(error,style:  TextStyle( color: Colors.red,))
            else if (city.isNotEmpty)

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    city,
                    style: TextStyle(
                      fontSize: 22, 
                      color: Colors.white,
                    ),
                    
                  ),
                  // SizedBox(height: 10,),
                  Text(
                    "$temp °C",
                    style: TextStyle(
                      fontSize: 50, 
                      color: Colors.white,
                    ),
                    
                  ),
                  SizedBox(height: 10,),

                  Text(
                    'Clear Sky',
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),

            )


          
          ],
         
        ),
      ),
    );
  }
}