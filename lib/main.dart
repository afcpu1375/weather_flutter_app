import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:water_flutter/Model/CurrentCityDataModel.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<CurrentCityDataModel> currentweatherFuture;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentweatherFuture=  sendRequestCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Weather App"),
        elevation: 15,
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return {'Setting', 'profile', 'logout'}.map((String Choice) {
                return PopupMenuItem(
                  value: Choice,
                  child: Text(Choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: FutureBuilder<CurrentCityDataModel>(
        future: currentweatherFuture,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return  SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/star.jpg"))),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("find")),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      hintText: "enter a city name ",
                                      border: UnderlineInputBorder()),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            "Mountain View",
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Clear sky",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Icon(
                            Icons.wb_sunny_outlined,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text("14" + "\u00B0",
                              style: TextStyle(color: Colors.white, fontSize: 60)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "max",
                                  style: TextStyle(color: Colors.grey, fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "16" + "\u00B0",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                width: 1,
                                height: 40,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "min",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "12" + "\u00B0",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            color: Colors.grey,
                            height: 1,
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    width: 75,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Text(
                                            "fri,8pm",
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 15),
                                          ),
                                          Icon(
                                            Icons.cloud,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "14" + "\u00B0",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            color: Colors.grey,
                            height: 1,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "wind speed",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "7.73 m/s",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "sunrise",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "9:19PM",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "sunset",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "9:3AM",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "humidity",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "72%",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }else{

            return Center(child:
              JumpingDotsProgressIndicator(
                color: Colors.black,
                fontSize: 60,
                dotSpacing: 2,
              ),);
          }
        },



      ),
    );
  }


  Future<CurrentCityDataModel> sendRequestCurrentWeather() async {
    var apiKey = 'adb49d03b2844478c6860aae676f0755';
    var cityname = "tehran";
    var response = await Dio().get(
        "https://api.openweathermap.org/data/2.5/weather",
        queryParameters: {'q': cityname, "appid": apiKey, "units": "metric"}

    );

    print(response.data);
    print(response.statusCode);


    var datamodel = CurrentCityDataModel(
        response.data['name'],
        response.data['coord']['lon'],
        response.data['coord']['lat'],
        response.data['weather'][0]['main'],
        response.data['weather'][0]['description'],
        response.data['main']['temp'],
        response.data['main']['temp_min'],
        response.data['main']['temp_max'],
        response.data['main']['pressure'],
        response.data['main']['humidity'],
        response.data['wind']['speed'],
        response.data['dt'],
        response.data['sys']['country'],
        response.data['sys']['sunrise'],
        response.data['sys']['sunset']);

    return datamodel;
  }
}
