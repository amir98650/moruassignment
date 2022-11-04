import 'package:flutter/material.dart';
import 'package:moruassignment/homepage.dart';

class SplassScreen extends StatefulWidget {
  const SplassScreen({super.key});

  @override
  State<SplassScreen> createState() => _SplassScreenState();
}

class _SplassScreenState extends State<SplassScreen> {
  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ));
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             ElevatedButton(
                child: const Text("Skip>>"),
                  onPressed:(){Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ));
                }),
            Stack(
              children: [
                Container(
                    padding:const EdgeInsets.all(10),
                    child: Image.asset("assets/splashimage.png")),
                const Positioned(
                    bottom: 250,
                    left: 70,
                    child: Text("We show weather for you",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20)),
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}
