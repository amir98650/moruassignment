import 'package:flutter/material.dart';
import 'package:moruassignment/models/weather_api_model.dart';
import 'package:moruassignment/sharedpreference.dart';
import 'package:moruassignment/splashscreen.dart';
import 'package:moruassignment/widget/weatherview.dart';

import 'api_repo/weather_api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final sharedPreference _preference = sharedPreference();
  weatherModel currentWeather = weatherModel();

  clickme(String val) {
    _preference.addStringToSF(val);
  }

  @override
  void initState() {
    super.initState();
    _preference.getStringValuesSF().then((value) => setState(() {
          if (value != null) {
            name.text = value;
            getWeather(value).then((value) => setState(() {
                  currentWeather = value;
                }));
          } else {
            getWeather("Nepal").then((value) => setState(() {
                  currentWeather = value;
                }));
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather Api"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplassScreen(),
                      ));
                },
                icon: const Icon(Icons.help))
          ],
        ),
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(key: _formKey, children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.place_outlined),
                      hintText: 'Enter place Name',
                      labelText: 'Place *',
                    ),
                    controller: name,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        clickme(name.text);
                        getWeather(name.text).then((value) => setState(() {
                              currentWeather = value;
                            }));
                      },
                      child: _preference.getStringValuesSF() == null
                          ? const Text("Save")
                          : const Text("update")),
                ],
              )),
            ),
            currentWeather.current != null
                ? WeatherView(
                    temp: currentWeather.current!.tempC.toString(),
                    condition:
                        currentWeather.current!.condition!.text.toString(),
                    location:
                        "https:${currentWeather.current!.condition!.icon}",
                  )
                : Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
          ]),
        ));
  }
}
