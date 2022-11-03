import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moruassignment/constants/urlconstants.dart';
import 'package:moruassignment/models/weather_api_model.dart';
import 'package:moruassignment/sharedpreference.dart';
import 'package:moruassignment/widget/weatherview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final sharedPreference _preference = sharedPreference();

  clickme(String val) {
    _preference.addStringToSF(val);
  }

  Future<weatherModel> getWeather() async {
    try {
      const url = urlConstants.baseurl;
      final response = await Dio().get(url);
      final unformatedata = response.data;
      final formateddata = weatherModel.fromJson(unformatedata);
      return formateddata;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _preference.getStringValuesSF().then((value) => setState(() {
          name.text = value!;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather Api"),
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
                        if (_formKey.currentState!.validate()) {
                          clickme(name.text);
                        } else {}
                      },
                      child: _preference.getStringValuesSF() != null
                          ? const Text("Save")
                          : const Text("update")),
                ],
              )),
            ),
            FutureBuilder<weatherModel>(
                future: getWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.red));
                  } else if (snapshot.connectionState == ConnectionState.done ||
                      snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.hasError == false) {
                      return WeatherView(
                        temp: snapshot.data!.current!.tempC.toString(),
                        condition:
                            snapshot.data!.current!.condition!.text.toString(),
                        location:
                            "https:${snapshot.data!.current!.condition!.icon}",
                      );
                    } else {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }
                }),
          ]),
        ));
  }
}
