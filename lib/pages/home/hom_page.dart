import 'package:asparagus_app/pages/classifly/select_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color.fromRGBO(160, 224, 213, 1.0),
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    const Text("ASPARAGUS", style: TextStyle(fontSize: 42.0, color: Colors.black, fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Image.asset("assets/images/logo.png", width: 250,),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(3, 27, 31, 1.0)
                        ),
                        onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => const SelectImage(),
                                )
                            );
                        }, 
                        child: const Padding(
                          padding:  EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                          child:  Text("START", style: TextStyle(fontSize: 20.0),),
                        )
                    )
                ],
            ),
        ),
    );
  }
}